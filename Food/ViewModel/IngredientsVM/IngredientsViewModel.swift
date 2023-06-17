//
//  IngredientsViewModel.swift
//  Food
//
//  Created by Ayberk Öz on 17.06.2023.
//

import Foundation
import UIKit

class IngredientsViewModel {
    
    private let foodService: FoodServiceProtocol
    weak var output : IngredientsViewModelOutput?
    
    private (set) var AllFoodsByIngredients : [IngredientsModel] = [] {
        didSet {
            output?.updateView(values: AllFoodsByIngredients)
        }
    }
    
    init(foodService: FoodServiceProtocol, output: IngredientsViewModelOutput? = nil) {
        self.foodService = foodService
    }
    
    func fetchFoodsByIngredients(query : [String], number: Int?) {
        
        let endpoint = Endpoint.findByIngredients(ingredients: query, number: number)
        
        foodService.fetchFoods(with: endpoint) { (result: Result<[IngredientsModel], FoodServiceError>) in
            switch result {
            case .success(let foodByIngredients):
                self.AllFoodsByIngredients = foodByIngredients
                print(self.AllFoodsByIngredients)
            case .failure(let error):
                print("Failed to fetch foods: \(error.localizedDescription)")
            }
            
        }
        
    }
    
}



