//
//  RecipeViewModel.swift
//  Food
//
//  Created by Ayberk Öz on 23.06.2023.
//

import Foundation

class RecipeViewModel {
    
    private let foodService : FoodServiceProtocol
    private let favListService : FavListProtocol
    weak var output : RecipeViewModelOutput?
    
    private (set) var Recipe : RecipeModel? {
        didSet {
            output?.updateView(value: Recipe!)
        }
    }
    
    private (set) var FavList: FavListModel? {
        didSet {
            output?.updateFavList(value: FavList!)
        }
    }
    
    init(foodService: FoodServiceProtocol, favListService: FavListProtocol, output: RecipeViewModelOutput? = nil) {
        self.foodService = foodService
        self.favListService = favListService
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
    
    func fetchFavList() {
        favListService.fetchFavList { [weak self] result in
            switch result {
            case .success(let favlist):
                self?.FavList = favlist
            case .failure(let error):
                print("Failed to get favlist: \(error.localizedDescription)")
            }
        }
    }
    
}
