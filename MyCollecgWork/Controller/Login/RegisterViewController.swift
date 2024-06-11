//
//  RegisterViewController.swift
//  SearchPhotos
//
//  Created by Нургазы Адилет on 03.06.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    
    private var labelSigin = UILabel()
    private lazy var emailText = UITextField()
    private lazy var passwordText = UITextField()
    private lazy var passwordCheckText = UITextField()
    private lazy var buttonSignUp = UIButton()
    private var imagePasswordIndicator = UIImageView()
    
    private let mainTabBarController = MainTabBarController()
    
    //MARK: - Frontend Class
    let frontText = FrontTextField()
    let frontButton = FrontendButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        setupNavigationController()
        setupLabel()
        setupTextEmail()
        setupTextPassword()
        setupTextCheckPassword()
        setupImageViewCheckPassword()
        checkMarkPassword()
        createTapGestureRecogize()
        setupUIButton()
        fireBaseAuth()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailText.text = ""
        passwordText.text = ""
        passwordCheckText.text = ""
    }
    
    
    //MARK: - NavigationController
    
    private func setupNavigationController() {
        // Добавляем кнопку "Назад" в навигационную панель
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left.circle"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
    }
    
    
    //MARK: - UITapGestureRecognizer
    
    private func createTapGestureRecogize() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - UILabel
    
    private func setupLabel() {
        labelSigin.text = "Sign up"
        labelSigin.textColor = .black
        labelSigin.font = .systemFont(ofSize: 35, weight: .medium)
        labelSigin.numberOfLines = 0
        view.addSubview(labelSigin)
        
        labelSigin.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.height.equalTo(130)
        }
    }
    
    //MARK: - UITextField
    
    private func setupTextEmail() {
        frontText.setupTextFieldEmail(textField: emailText, placeholder: "Enter email")
        view.addSubview(emailText)
        emailText.delegate = self
        
        emailText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelSigin.snp.bottom).offset(25)
            make.width.equalTo(300)
            make.height.equalTo(35)
        }
        
    }
    
    private func setupTextPassword() {
        frontText.setupTextFieldPassword(textField: passwordText, placeholder: "Enter password")
        view.addSubview(passwordText)
        passwordText.delegate = self
        
        passwordText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailText.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(35)
        }
        
    }
    
    
    private func setupTextCheckPassword() {
        frontText.setupTextFieldPassword(textField: passwordCheckText, placeholder: "Check password")
        passwordCheckText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.view.addSubview(passwordCheckText)
        passwordCheckText.delegate = self
        
        passwordCheckText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordText.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(35)
        }
        
        setupImageViewCheckPassword()
    }
    
    //MARK: - UIButton
    
    private func setupUIButton() {
        frontButton.setupButton(button: buttonSignUp, title: "Sign Up", tintColor: .black, backgroundColor: .white)
        view.addSubview(buttonSignUp)
        buttonSignUp.addTarget(self, action: #selector(tapSignIn), for: .touchUpInside)
        buttonSignUp.alpha = 0.5
        
        buttonSignUp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordCheckText.snp.bottom).offset(30)
            make.width.equalTo(150)
            make.height.equalTo(35)

        }
        
    }
    
    //MARK: - UIImageView
       private func setupImageViewCheckPassword() {
           view.addSubview(imagePasswordIndicator)
        
           imagePasswordIndicator.snp.makeConstraints { make in
               make.centerY.equalTo(passwordCheckText)
               make.trailing.equalTo(passwordCheckText.snp.leading).offset(-5)
               make.width.height.equalTo(20)
           }
           checkMarkPassword()
       }
       
    
    //Проверка пароля индикатор 
       private func checkMarkPassword() {
           if passwordText.text == passwordCheckText.text {
               imagePasswordIndicator.image = UIImage(systemName: "checkmark.circle.fill")
               imagePasswordIndicator.tintColor = .green
           } else {
               imagePasswordIndicator.image = UIImage(systemName: "xmark.circle")
               imagePasswordIndicator.tintColor = .red
           }
       }
    
    private func updateSignUpButtonState() {
          if emailText.text?.isEmpty == false, passwordText.text?.isEmpty == false, passwordCheckText.text?.isEmpty == false {
              buttonSignUp.isEnabled = true
              buttonSignUp.alpha = 1.0
          } else {
              buttonSignUp.isEnabled = false
              buttonSignUp.alpha = 0.5
          }
      }
       
       @objc private func textFieldDidChange(_ textField: UITextField) {
           updateSignUpButtonState()
           checkMarkPassword()
       }

    
    @objc private func tapSignIn() {
        
        guard let password = passwordText.text, let chekPassword = passwordCheckText.text, password == chekPassword else {
            ErrorAllert.shared.errorUserAllert(in: self, title: "Ошибка", massge: "Пароли не совпадают")
            return
        }
        
        
        guard let email = emailText.text, let password = passwordText.text, email != "", password != "" else {
            ErrorAllert.shared.errorUserAllert(in: self, title: "Error", massge: "информация не коректно")
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                if user != nil {
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        sceneDelegate.changeRootViewController(MainTabBarController())
                        
                    } else {
                        print("user не создался")
                    }
                }
            }
        }
        
    }
    private func fireBaseAuth() {
        FirebaseAuth.Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user != nil, self?.emailText.text != "", self?.passwordText.text != "" {
                
            } else {
                print("user is not created")
            }
        }
    }

    
    
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    @objc private func backButtonTapped() {
          navigationController?.popViewController(animated: true)
      }
}



extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Скрываем клавиатуру
        textField.resignFirstResponder()
        return true
    }
    
}
