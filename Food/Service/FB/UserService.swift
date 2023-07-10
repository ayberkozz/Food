//
//  UserService.swift
//  Food
//
//  Created by Ayberk Öz on 10.07.2023.
//

import Foundation
import Firebase


protocol UserServiceProtocol {
    func getUserInfo(completion: @escaping (Result<AuthModel, UserServiceError>) -> Void)
}

class UserService : UserServiceProtocol {
    
    let fireStoreDatabase = Firestore.firestore()

    func getUserInfo(completion: @escaping (Result<AuthModel, UserServiceError>) -> Void) {
        guard let currentUserEmail = Auth.auth().currentUser?.email else {
            completion(.failure(.unauthenticated))
            return
        }
        
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo: currentUserEmail).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(.other(error.localizedDescription)))
                return
            }
            
            if let snapshot = snapshot, !snapshot.isEmpty, let document = snapshot.documents.first {
                if let username = document.get("username") as? String {
                    let authModel = AuthModel(email: currentUserEmail, username: username)
                    completion(.success(authModel))
                } else {
                    completion(.failure(.usernameNotFound))
                }
            } else {
                completion(.failure(.documentNotFound))
            }
        }
    }
}

enum UserServiceError: Error {
    case unauthenticated
    case documentNotFound
    case usernameNotFound
    case other(String)
}
