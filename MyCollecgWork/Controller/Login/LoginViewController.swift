//
//  LoginViewController.swift
//  SearchPhotos
//
//  Created by Нургазы Адилет on 03.06.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let labelLogin = UILabel()
    private lazy var textEmail = UITextField()
    private lazy var textPassword = UITextField()
    private lazy var loginButton = UIButton()
    private lazy var registerButton = UIButton()
    
    private var imageSerachPhotos: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "playstore")
        return image
    }()
    
    private var frontTextField = FrontTextField()
    private var frontButton = FrontendButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLabel()
        setupTextFieldEmail()
        setupTextFieldPassword()
        createTapGestureRecogize()
        setupLoginButton()
        setupRegisterButton()
        setupImageView()
        
        FirebaseAuth.Auth.auth().addStateDidChangeListener {  (auth, user) in
            if user != nil {
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    sceneDelegate.changeRootViewController(MainTabBarController())
                    
                }
            }
        }
    }
        //MARK: - UITapGestureRecognizer
        
        private func createTapGestureRecogize() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
        }
        
        //MARK: - UILabel
        
        private func setupLabel() {
            labelLogin.text = "Login"
            labelLogin.textColor = .black
            labelLogin.font = .systemFont(ofSize: 35, weight: .medium)
            labelLogin.textAlignment = .center
            labelLogin.numberOfLines = 0
            view.addSubview(labelLogin)
            
            labelLogin.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(200)
                make.width.height.equalTo(100)
            }
        }
        
        //MARK: - UITextField
        
        private func setupTextFieldEmail() {
            frontTextField.setupTextFieldEmail(textField: textEmail, placeholder: "Enter email")
            view.addSubview(textEmail)
            textEmail.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            textEmail.delegate = self
            
            textEmail.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(labelLogin.snp.bottom).offset(40)
                make.width.equalTo(300)
                make.height.equalTo(35)
            }
        }
        
        private func setupTextFieldPassword() {
            frontTextField.setupTextFieldPassword(textField: textPassword, placeholder: "Enter password")
            view.addSubview(textPassword)
            textPassword.delegate = self
            textPassword.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            textPassword.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(textEmail.snp.bottom).offset(25)
                make.width.equalTo(300)
                make.height.equalTo(35)
            }
            
        }
        
        //выход с аккаунта
        
        static func signOut() {
            try? Auth.auth().signOut()
        }
        
        //Логика доступность текста
        @objc func textFieldDidChange() {
            checkFieldsAndUpdateButton()
        }
        
        func checkFieldsAndUpdateButton() {
            if textEmail.text == "" || textPassword.text == "" {
                loginButton.alpha = 0.5
                loginButton.isEnabled = false
            } else {
                loginButton.alpha = 1.0
                loginButton.isEnabled = true
            }
        }
        
        //MARK: - UIButton
        
        private func setupLoginButton() {
            frontButton.setupButton(button: loginButton, title: "Sign in", tintColor: .black, backgroundColor: .white)
            view.addSubview(loginButton)
            loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
            loginButton.alpha = 0.5
            
            loginButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(textPassword.snp.bottom).offset(40)
                make.width.equalTo(150)
                make.height.equalTo(35)
            }
        }
        
        
        private func setupRegisterButton() {
            frontButton.setupButton(button: registerButton, title: "Create account", tintColor: .black, backgroundColor: .white)
            view.addSubview(registerButton)
            registerButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
            registerButton.layer.borderWidth = 0
            registerButton.layer.borderColor = UIColor.clear.cgColor
            registerButton.setTitleColor(.systemBlue, for: .normal)
            
            registerButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(loginButton.snp.bottom).offset(20)
                make.width.equalTo(150)
                make.height.equalTo(35)
            }
            
        }
        
        
        //MARK: - ImageView
        
        private func setupImageView() {
            view.addSubview(imageSerachPhotos)
            imageSerachPhotos.contentMode = .scaleAspectFill
            
            imageSerachPhotos.snp.makeConstraints { make in
                make.width.height.equalTo(100)
                make.centerX.equalToSuperview()
                make.top.equalTo(100)
            }
        }
        
        //скрытия клавиатуры при нажатие на экран
        @objc private func dismissKeyboard() {
            view.endEditing(true)
        }
        
        
        
        
        //Action LoginButton
        @objc private func loginButtonAction() {
            print("Нажали на кнопку log in")
            
            
            guard let email = textEmail.text, let password = textPassword.text, email != "", password != "" else {
                ErrorAllert.shared.errorUserAllert(in: self, title: "Error", massge: "info is incorrect")
                return
            }
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self](user, error) in
                if error != nil {
                    ErrorAllert.shared.errorUserAllert(in: self!, title: "Error", massge: "Возникла ошибка")
                    return
                }
                if user != nil {
                    
                    
                }
                
            }
            
        }
    
       
  

    
    
    //Action RegisterButton

    @objc private func signIn() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}
    
    

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Скрываем клавиатуру
        textField.resignFirstResponder()
        return true
    }
}
