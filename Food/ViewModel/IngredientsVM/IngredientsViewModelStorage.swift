//
//  IngredientsViewModelStorage.swift
//  Food
//
//  Created by Ayberk Öz on 17.06.2023.
//

import Foundation
import UIKit

protocol IngredientsViewModelOutput : AnyObject {
    func updateView(values: [IngredientsModel])
}
