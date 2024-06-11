//
//  Users.swift
//  SearchPhotos
//
//  Created by Нургазы Адилет on 05.06.2024.
//

import Foundation
import Firebase
import FirebaseAuth

class Users {
    static let shared = Users()
    
    private init() {}
    
    func fireAuthSignIn(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = user {
                completion(.success(user))
            }
        }
    }
}
