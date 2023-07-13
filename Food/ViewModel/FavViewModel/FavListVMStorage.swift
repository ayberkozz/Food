//
//  FavListVMStorage.swift
//  Food
//
//  Created by Ayberk Öz on 12.07.2023.
//

import Foundation
import UIKit

protocol FavListVMOutput : AnyObject {
    func updateView(recipeUpdate: RecipeModel)
    func updateFavs(value: FavListModel)
    func updateRecipe(recipe: RecipeModel, at indexPath: IndexPath)
}
