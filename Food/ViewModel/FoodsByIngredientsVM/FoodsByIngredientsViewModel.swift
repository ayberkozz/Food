//
//  IngredientsViewModel.swift
//  Food
//
//  Created by Ayberk Öz on 17.06.2023.
//

import Foundation
import UIKit

class FoodsByIngredientsViewModel {
    
    private let foodService: FoodServiceProtocol
    weak var output : FoodsByIngredientsViewModelOutput?
    
    private (set) var AllFoodsByIngredients : [FoodsByIngredientsModel] = [] {
        didSet {
            output?.updateView(values: AllFoodsByIngredients)
        }
    }
    
    init(foodService: FoodServiceProtocol, output: FoodsByIngredientsViewModelOutput? = nil) {
        self.foodService = foodService
    }
    
    func fetchFoodsByIngredients(query : [String]/*, number: Int?*/) {
        
        let endpoint = Endpoint.findByIngredients(ingredients: query/*, number: number*/)
        
        foodService.fetchFoods(with: endpoint) { (result: Result<[FoodsByIngredientsModel], FoodServiceError>) in
            switch result {
            case .success(let foodByIngredients):
                self.AllFoodsByIngredients = foodByIngredients
            case .failure(let error):
                print("Failed to fetch foods: \(error.localizedDescription)")
            }
            
        }
        
    }
    
}



