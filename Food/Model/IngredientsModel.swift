//
//  IngredientsModel.swift
//  Food
//
//  Created by Ayberk Öz on 16.06.2023.
//

import Foundation

// MARK: - DisneyMElement
struct IngredientsModel: Codable {
    let id: Int
    let image: String
    let imageType: String
    let likes, missedIngredientCount: Int
    let missedIngredients: [IngredientsDetailModel]
    let title: String
    let unusedIngredients: [IngredientsDetailModel]
    let usedIngredientCount: Int
    let usedIngredients: [IngredientsDetailModel]
}

// MARK: - SedIngredient
struct IngredientsDetailModel: Codable {
    let aisle: String
    let amount: Double
    let id: Int
    let image: String
    let meta: [String]
    let name, original, originalName, unit: String
    let unitLong, unitShort: String
    let extendedName: String?
}
