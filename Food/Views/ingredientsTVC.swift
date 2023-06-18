//
//  ingredientsTVC.swift
//  Food
//
//  Created by Ayberk Öz on 17.06.2023.
//

import Foundation
import UIKit

class ingredientsTVC: UITableViewCell {

    static let reuseIdentifier = "ingredientsTVCIdentifier"
    
    var isSelectedItem: Bool = false {
        didSet {
            accessoryType = isSelectedItem ? .checkmark : .none
        }
    }

}
