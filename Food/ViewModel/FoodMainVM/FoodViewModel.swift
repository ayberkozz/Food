//
//  FoodViewModel.swift
//  Food
//
//  Created by Ayberk Öz on 13.06.2023.
//

import Foundation
import UIKit

class FoodViewModel {
    
    private let foodService : FoodServiceProtocol
    weak var output : FoodViewModelOutput?
    
    private(set) var AllFoods: [FoodDetailModel] = [] {
        didSet {
            output?.updateView(values: AllFoods)
        }
    }
        
    init(foodService: FoodServiceProtocol, output: FoodViewModelOutput? = nil) {
        self.foodService = foodService
    }
    
    func fetchFoods(query: String?, parameters: SearchParameters) {
        
        let endpoint: Endpoint
        
        endpoint = Endpoint.complexSearch(query: query, maxFat: parameters.maxFat, diet: parameters.diet, number: parameters.number)

        foodService.fetchFoods(with: endpoint) { [weak self] (result: Result<FoodModel, FoodServiceError>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let foods):
                let foodResults = foods.results
                self.AllFoods = foodResults
            case .failure(let error):
                print("Failed to fetch foods: \(error.localizedDescription)")
                self.AllFoods = []
            }
        }
    }
    
}

