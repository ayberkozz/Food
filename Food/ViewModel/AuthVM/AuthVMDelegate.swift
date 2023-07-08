//
//  AuthVMDelegate.swift
//  Food
//
//  Created by Ayberk Öz on 8.07.2023.
//

import Foundation

protocol AuthViewModelDelegate: AnyObject {
    func didSignUpSuccessfully()
    func didSignInSuccessfully()
    func didSignOutSuccessfully()
}
