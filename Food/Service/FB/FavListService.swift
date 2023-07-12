//
//  FavListService.swift
//  Food
//
//  Created by Ayberk Öz on 12.07.2023.
//

import Foundation
import Firebase

protocol FavListProtocol {
    func fetchFavList(completion: @escaping (Result<FavListModel,Error>)-> Void)
}

class FavListService : FavListProtocol {
    
    let fireStoreDataBase = Firestore.firestore()
    
    func fetchFavList(completion: @escaping (Result<FavListModel, Error>) -> Void) {
        
        let username = AuthModel.sharedUserInfo.username
        fireStoreDataBase.collection("fav")
            .whereField("username", isEqualTo: username).addSnapshotListener { snapshot, error in
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        if let username = document.get("username") as? String {
                            if let favArray = document.get("favs") as? [String] {
                                let favListModel = FavListModel(favs: favArray, username: username)
                                completion(.success(favListModel))
                                print(favListModel)
                            }
                        }
                    }
                    
                } else {
                    print(error?.localizedDescription ?? "snapshot is empty or nil fav list service")
                }
                
            }
        
    }
}


