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
    
    func fetchFoods(query: String?, maxFat: Int?, number: Int?) {
        
        let endpoint: Endpoint
        
        if let number = number {
            endpoint = Endpoint.complexSearch(query: query, maxFat: maxFat, number: number)
        } else {
            endpoint = Endpoint.complexSearch(query: query, maxFat: maxFat, number: nil)
        }
        
        foodService.fetchFoods(with: endpoint) { (result: Result<FoodModel, FoodServiceError>) in
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

