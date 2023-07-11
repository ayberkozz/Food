//
//  AuthModel.swift
//  Food
//
//  Created by Ayberk Öz on 8.07.2023.
//

import Foundation

struct AuthModel {
        
    static var sharedUserInfo = AuthModel(email: "", username: "")
    
    var email : String
    var username : String
        
}

//class AuthModel {
//
//    static let sharedUserInfo = UserSingleton()
//
//    var email = ""
//    var username = ""
//
//    private init() {
//
//    }
//
//
//}
