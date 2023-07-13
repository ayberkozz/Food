//
//  RecipeViewModelStorage.swift
//  Food
//
//  Created by Ayberk Öz on 23.06.2023.
//

import Foundation
import UIKit

protocol RecipeViewModelOutput : AnyObject {
    func updateView(value: RecipeModel)
    func updateFavList(value: FavListModel)
}

