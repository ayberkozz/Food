//
//  IngredientsTVC.swift
//  Food
//
//  Created by Ayberk Öz on 15.06.2023.
//

import UIKit

class IngredientsTVC: UITableViewCell {

    static let reuseIdentifier = "IngredientsTVCIdentifier"
    
    var isSelectedItem: Bool = false {
        didSet {
            accessoryType = isSelectedItem ? .checkmark : .none
        }
    }

}
