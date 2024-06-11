//
//  NavigationViewController.swift
//  SearchPhotos
//
//  Created by Нургазы Адилет on 04.06.2024.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginViewController = LoginViewController()
        let registerViewController = RegisterViewController()
        let mainTabBarController = MainTabBarController()
        let photosViewController = PhotosCollectionViewController()
        
        
        self.setViewControllers([loginViewController, registerViewController, mainTabBarController, photosViewController], animated: false)
        
    }
    

   

}
