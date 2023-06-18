//
//  IngredientsModel.swift
//  Food
//
//  Created by Ayberk Öz on 16.06.2023.
//

import Foundation

// MARK: - DisneyMElement
struct FoodsByIngredientsModel: Codable {
    let id: Int
    let image: String
    let imageType: String
    let likes, missedIngredientCount: Int
    let missedIngredients: [FoodsByIngredientsDetailModel]
    let title: String
    let unusedIngredients: [FoodsByIngredientsDetailModel]
    let usedIngredientCount: Int
    let usedIngredients: [FoodsByIngredientsDetailModel]
}

// MARK: - SedIngredient
struct FoodsByIngredientsDetailModel: Codable {
    let aisle: String
    let amount: Double
    let id: Int
    let image: String
    let meta: [String]
    let name, original, originalName, unit: String
    let unitLong, unitShort: String
    let extendedName: String?
}
