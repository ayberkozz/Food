//
//  IngredientsViewModelStorage.swift
//  Food
//
//  Created by Ayberk Öz on 17.06.2023.
//

import Foundation
import UIKit

protocol FoodsByIngredientsViewModelOutput : AnyObject {
    func updateView(values: [FoodsByIngredientsModel])
}
