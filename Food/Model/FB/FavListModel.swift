//
//  FavListModel.swift
//  Food
//
//  Created by Ayberk Öz on 12.07.2023.
//

import Foundation

struct FavListModel {
    
    static var sharedFavList = FavListModel(favs: [""], username: "")
    
    var favs : [String]
    var username : String
    
}
