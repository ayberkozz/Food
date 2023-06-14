//
//  FoodViewModel.swift
//  Food
//
//  Created by Ayberk Öz on 13.06.2023.
//

import Foundation
import UIKit

class FoodViewModel {
    
    private let foodService : FoodService
    weak var output : FoodViewModelOutput?
    
    private(set) var AllFoods: [FoodDetailModel] = [] {
        didSet {
            output?.updateView(values: AllFoods)
        }
    }
    
    private(set) var filteredFoods : [FoodDetailModel] = []
    
    init(foodService: FoodService, output: FoodViewModelOutput? = nil) {
        self.foodService = foodService
    }
    
    func fetchFoods(query: String?, maxFat: Int?, number: Int?) {
        
        let endpoint = Endpoint.complexSearch(query: query, maxFat: maxFat, number: number)

        foodService.fetchFoods(with: endpoint) { [weak self] result in
            switch result {
            case .success(let foods):
                self?.AllFoods = foods
                print(self?.AllFoods)
            case .failure(let error):
                print("Failed to fetch foods: \(error.localizedDescription)")
            }
        }
    }
}

//extension FoodViewModel {
//    public func inSerchMode(_ searchController: UISearchController) -> Bool {
//        let isActive = searchController.isActive
//        let searchText = searchController.searchBar.text ?? ""
//        
//        return isActive && !searchText.isEmpty
//    }
//    
//    
//    public func updateSearchController(searchBarText: String?) {
//        self.filteredFoods = AllFoods
//        
//        if let searchText = searchBarText?.lowercased() {
//            guard !searchText.isEmpty else {self.output?.updateView(values: []); return}
//            
//            self.filteredFoods = self.filteredFoods.filter({
//                $0.title.lowercased().contains(searchText)
//            })
//        }
//        self.output?.updateView(values: self.AllFoods)
//    }
//
//}
