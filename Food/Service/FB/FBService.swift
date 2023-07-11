//
//  FBService.swift
//  Food
//
//  Created by Ayberk Öz on 11.07.2023.
//

import Foundation
import Firebase

protocol FBServiceProtocol {
    func FBService(favIDs: [String])
}

class FBService : FBServiceProtocol {
    
    let fireStore = Firestore.firestore()
    
    func FBService(favIDs: [String]) {
        fireStore.collection("fav").whereField("username", isEqualTo: AuthModel.sharedUserInfo.username).getDocuments { snapshot, err in
            if err != nil {
                print(err?.localizedDescription ?? "Error get favs")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        
                        let documentId = document.documentID
                        
                        let additionalDictionary = ["favs": favIDs] as [String : Any]
                        
                        self.fireStore.collection("fav").document(documentId).setData(additionalDictionary, merge: true) { err in
                            if err == nil {
                                print("data uploaded (set")
                            }
                            
                        }
                        
                    }
                } else {
                    let favDictionary = ["favs":favIDs, "username":AuthModel.sharedUserInfo.username] as [String:Any]
                    
                    self.fireStore.collection("fav").addDocument(data: favDictionary) { err in
                        if err != nil {
                            print(err?.localizedDescription ?? "error add document")
                        } else {
                            print("data uploaded (add)")
                        }
                        
                    }
                }
            }
        }
    }
    
}
