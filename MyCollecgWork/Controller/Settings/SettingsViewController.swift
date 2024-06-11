//
//  SettingsViewController.swift
//  MyCollecgWork
//
//  Created by Нургазы Адилет on 07.06.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    
    private let tableView = UITableView()
    private lazy var cells: [UITableViewCell] = [
        SettingTableViewCell()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSettingBar()
        setupTableViewController()
    }
    
    //MARK: - UINavigationBar
    private func setupSettingBar() {
        navigationItem.title = "Setting"
    }
    
    //MARK: UITableView
    
    private func setupTableViewController() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}


//MARK: UITableViewDataSourse

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingTableViewCell
        
        return cell
    }
    
    
}

//MARK: UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Проверяем, что нажата именно ячейка "Выйти с аккаунта"
        if indexPath.row == 0 {
            exitAlertController()
            
        }
    }
    
    private func exitAlertController() {
        let alert = UIAlertController(title: "Предупреждение", message: "Вы уверены, что хотите выйти с аккаунта?", preferredStyle: .alert)
        let alertActionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        // Добавляем кнопку "Да" и обработчик для нее
             let alertActionOK = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
                 guard let self = self else { return }
                 
                 // Выполняем выход из аккаунта
                 try? Auth.auth().signOut()
                 
                 // Переходим на экран логина
                 if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                     let loginViewController = UINavigationController(rootViewController: LoginViewController())
                     sceneDelegate.changeRootViewController(loginViewController)
                 }
             }
             
             alert.addAction(alertActionOK)
             alert.addAction(alertActionCancel)
             
             present(alert, animated: true, completion: nil)
         }    }
    

