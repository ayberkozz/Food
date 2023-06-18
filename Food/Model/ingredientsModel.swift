//
//  ingredientsModel.swift
//  Food
//
//  Created by Ayberk Öz on 17.06.2023.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let id: Int
    let original, originalName, name: String
    let amount: Int
    let unit, unitShort, unitLong: String
    let possibleUnits: [String]
    let estimatedCost: EstimatedCost
    let consistency: String
    let shoppingListUnits: [String]
    let aisle, image: String
    let nutrition: Nutrition
    let categoryPath: [String]
}

// MARK: - EstimatedCost
struct EstimatedCost: Codable {
    let value: Int
    let unit: String
}

// MARK: - Nutrition
struct Nutrition: Codable {
    let nutrients, properties, flavonoids: [Flavonoid]
    let caloricBreakdown: CaloricBreakdown
    let weightPerServing: WeightPerServing
}

// MARK: - CaloricBreakdown
struct CaloricBreakdown: Codable {
    let percentProtein, percentFat, percentCarbs: Double
}

// MARK: - Flavonoid
struct Flavonoid: Codable {
    let name: String
    let amount: Double
    let unit: String
    let percentOfDailyNeeds: Double?
}

// MARK: - WeightPerServing
struct WeightPerServing: Codable {
    let amount: Int
    let unit: String
}

