//
//  ViewController.swift
//  SearchPhotos
//
//  Created by Нургазы Адилет on 03.06.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let photosVC = PhotosCollectionViewController(collectionViewLayout: WaterfallLayout())
        
        let likesVC = LikesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let settingVC = SettingsViewController()
        
        viewControllers = [
            generateNavigationController(rootViewController: photosVC, title: "Photos", image: UIImage(named: "photos")!),
            generateNavigationController(rootViewController: likesVC, title: "Favourites", image: UIImage(named: "heart")!),
            generateNavigationController(rootViewController: settingVC, title: "Setting", image: UIImage(systemName: "gearshape")!)
        ]
        
        navigationController?.navigationBar.tintColor = .black
    }
    
   
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
