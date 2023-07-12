//
//  FavViewModel.swift
//  Food
//
//  Created by Ayberk Öz on 12.07.2023.
//

import Foundation

class FavListViewModel {

    private let favListService : FavListProtocol
    weak var output : FavListVMOutput?
    
    private (set) var Favlist : FavListModel? {
        didSet {
            output?.updateFavs(value: Favlist!)
        }
    }

    init(favListService: FavListProtocol, output: FavListVMOutput? = nil) {
        self.favListService = favListService
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
