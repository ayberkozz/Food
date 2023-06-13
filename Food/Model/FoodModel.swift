//
//  FoodModel.swift
//  Food
//
//  Created by Ayberk Öz on 9.06.2023.
//

import Foundation

// MARK: - FoodModel
struct FoodModel: Codable {
    let results: [FoodDetailModel]
    let offset, number, totalResults: Int
}

// MARK: - FoodDetailModel
struct FoodDetailModel: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: ImageType
}

enum ImageType: String, Codable {
    case jpg = "jpg"
}
