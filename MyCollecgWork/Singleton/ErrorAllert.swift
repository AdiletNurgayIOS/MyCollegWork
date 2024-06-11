//
//  ErrorAllert.swift
//  SearchPhotos
//
//  Created by Нургазы Адилет on 05.06.2024.
//

import UIKit
import Foundation

class ErrorAllert {
    static let shared = ErrorAllert()
    
    private init() {}
    
    func errorUserAllert(in viewController: UIViewController, title: String, massge: String) {
        let alert = UIAlertController(title: title, message: massge, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(alertAction)
        viewController.present(alert, animated: true)
    }

}
