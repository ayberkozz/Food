//
//  FoodViewModelStorage.swift
//  Food
//
//  Created by Ayberk Öz on 13.06.2023.
//

import Foundation
import UIKit

protocol FoodViewModelOutput : AnyObject {
    func updateView(values: [FoodDetailModel])
}
