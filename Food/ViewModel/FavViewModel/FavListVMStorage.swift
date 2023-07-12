//
//  FavListVMStorage.swift
//  Food
//
//  Created by Ayberk Öz on 12.07.2023.
//

import Foundation
import UIKit

protocol FavListVMOutput : AnyObject {
    func updateFavs(value: FavListModel)
}
