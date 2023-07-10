//
//  UserViewModel.swift
//  Food
//
//  Created by Ayberk Öz on 10.07.2023.
//

import Foundation

class UserViewModel {
    
    private let UserService : UserServiceProtocol
    weak var output : UserViewModelOutput?
    
    private (set) var User : AuthModel? {
        didSet {
            output?.updateView(value: User!)
        }
    }
     
    init(UserService: UserServiceProtocol, output: UserViewModelOutput? = nil) {
        self.UserService = UserService
    }
    
    func fetchUser() {
        UserService.getUserInfo { [weak self] result in
            switch result {
            case .success(let user):
                self?.User = user
            case .failure(let error):
                print("Failed to get user information: \(error.localizedDescription)")
            }
        }
    }
    
}

