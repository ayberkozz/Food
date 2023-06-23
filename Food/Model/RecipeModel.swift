//
//  RecipeModel.swift
//  Food
//
//  Created by Ayberk Öz on 23.06.2023.
//

import Foundation

//MARK: - RecipeModel
struct RecipeModel: Codable {
    let id: Int
    let summary, title: String
}
