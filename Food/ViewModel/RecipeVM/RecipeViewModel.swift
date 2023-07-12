//
//  RecipeViewModel.swift
//  Food
//
//  Created by Ayberk Öz on 23.06.2023.
//

import Foundation

class RecipeViewModel {
    
    private let foodService : FoodServiceProtocol
    weak var output : RecipeViewModelOutput?
    
    private (set) var Recipe : RecipeModel? {
        didSet {
            output?.updateView(value: Recipe!)
        }
    }
    
    init(foodService: FoodServiceProtocol, output: RecipeViewModelOutput? = nil) {
        self.foodService = foodService
    }
    
    func fetchRecipe(id: Int!) {
        
        guard let id = id else {
            return
        }
        
        let endpoint = Endpoint.recipe(id: id)
        
        foodService.fetchFoods(with: endpoint) { (result: Result<RecipeModel,FoodServiceError>) in
            switch result {
            case .success(let recipe):
                self.Recipe = recipe
            case .failure(let error):
                print("Failed to fetch foods: \(error.localizedDescription)")
            }
        }
    }
    
}
