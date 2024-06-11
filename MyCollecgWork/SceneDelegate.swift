//
//  SceneDelegate.swift
//  MyCollecgWork
//
//  Created by Нургазы Адилет on 06.06.2024.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
           NotificationCenter.default.addObserver(self, selector: #selector(changeVC(notification:)), name: NSNotification.Name("changeVc"), object: nil)
           
           guard let windowScene = (scene as? UIWindowScene) else { return }
           let window = UIWindow(windowScene: windowScene)
           
           if Auth.auth().currentUser != nil {
               window.rootViewController = MainTabBarController()
           } else {
               window.rootViewController = UINavigationController(rootViewController: LoginViewController())
           }
           
           window.makeKeyAndVisible()
           self.window = window
       }

       @objc func changeVC(notification: Notification) {
           guard let isLogin = notification.userInfo?["isLogin"] as? Bool else { return }
           if isLogin {
               
               self.window?.rootViewController = MainTabBarController()
           } else {
               self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
           }
       }
    
     func changeRootViewController(_ vc: UIViewController) {
          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first else {
              return
          }
          window.rootViewController = vc
          UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: nil, completion: nil)
      }
       

    func sceneDidDisconnect(_ scene: UIScene) {
        NotificationCenter.default.removeObserver(self)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

