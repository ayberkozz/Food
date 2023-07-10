//
//  UserViewModelStorage.swift
//  Food
//
//  Created by Ayberk Öz on 10.07.2023.
//

import Foundation
import UIKit

protocol UserViewModelOutput : AnyObject {
    func updateView(value: AuthModel)
}
