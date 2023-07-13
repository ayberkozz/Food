//
//  FavViewModel.swift
//  Food
//
//  Created by Ayberk Öz on 12.07.2023.
//

import Foundation

class FavListViewModel {

    private let foodService : FoodServiceProtocol
    private let favListService : FavListProtocol
    weak var output : FavListVMOutput?
    
    private (set) var Recipe : RecipeModel? {
        didSet {
            output?.updateView(recipeUpdate: Recipe!)
        }
    }
    
    private (set) var Favlist : FavListModel? {
        didSet {
            output?.updateFavs(value: Favlist!)
        }
    }

    init(foodService: FoodServiceProtocol, favListService: FavListProtocol, output: RecipeViewModelOutput? = nil) {
        self.foodService = foodService
        self.favListService = favListService
    }
    
    func fetchRecipe(id: Int!, indexPath: IndexPath) {
        guard let id = id else {
            return
        }
        
        let endpoint = Endpoint.recipe(id: id)
        
        foodService.fetchFoods(with: endpoint) { [weak self] (result: Result<RecipeModel, FoodServiceError>) in
            switch result {
            case .success(let recipe):
                self?.Recipe = recipe
                self?.output?.updateRecipe(recipe: recipe, at: indexPath)
            case .failure(let error):
                print("Failed to fetch foods: \(error.localizedDescription)")
            }
        }
    }


    func fetchFavList() {
        favListService.fetchFavList { [weak self] result in
            switch result {
            case .success(let favlist):
                self?.Favlist = favlist
            case .failure(let error):
                print("Failed to get favlist: \(error.localizedDescription)")
            }
        }
    }

}
