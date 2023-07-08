//
//  AuthVM.swift
//  Food
//
//  Created by Ayberk Öz on 8.07.2023.
//

import Foundation
import Firebase

class AuthViewModel {
    
    private var showError : Bool = false
    weak var delegate: AuthViewModelDelegate?
    
    private func signUp(email: String, username:String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "Error creating user")
                self.showError.toggle()
                return
            }
            
            let firestore = Firestore.firestore()
            let data = ["email": email, "username": username] as [String: Any]
            
            firestore.collection("UserInfo").addDocument(data: data) { error in
                
                guard error == nil else {
                    print(error?.localizedDescription ?? "Error creating user")
                    self.showError.toggle()
                    return
                }
                
            }
            self.delegate?.didSignUpSuccessfully()
        }
        
    }
    
    private func signIn(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result ,error in
            guard error == nil else {
                print(error?.localizedDescription ?? "Error")
                return
            }
            self.delegate?.didSignInSuccessfully()
        }
        
    }
    
    private func logOut(){
        try? Auth.auth().signOut()
        self.delegate?.didSignOutSuccessfully()
    }
    
}



