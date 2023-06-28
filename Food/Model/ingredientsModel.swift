//
//  ingredientsModel.swift
//  Food
//
//  Created by Ayberk Öz on 17.06.2023.
//

import Foundation

struct Ingredients {
    let IngredientName : String
//    let id : Int
    
    init(raw: [String]) {
        IngredientName = raw[0]
//        id = raw[1]
    }

}

func loadCSV(from csvName: String) -> [Ingredients] {
    
    var csvToStruct = [Ingredients]()
    
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        return []
    }
    
    var data = ""
    do {
        data = try String(contentsOfFile: filePath)
    } catch {
        print(error)
        return []
    }
    
    var rows = data.components(separatedBy: "\n")
    
    let columnCount = rows.first?.components(separatedBy: ",").count
    rows.removeFirst()
    
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        if csvColumns.count == columnCount {
            let ingredientsStruct = Ingredients.init(raw: csvColumns)
            csvToStruct.append(ingredientsStruct)
        }
    }
    
    return csvToStruct
}
