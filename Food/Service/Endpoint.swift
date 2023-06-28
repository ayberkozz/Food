//
//  Endpoiny.swift
//  Food
//
//  Created by Ayberk Öz on 13.06.2023.
//

import Foundation

enum Endpoint {

    case complexSearch(query: String?, maxFat: Int?, number: Int?, diet: String?)
    case findByIngredients(ingredients: [String]/*, number: Int?*/)
    case recipe(id:Int)
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        return request
    }
    
    private var url: URL? {
        var components: URLComponents?
        var queryItems = [URLQueryItem]()
        
        switch self {
        case .complexSearch(let query, let maxFat, let number, let diet):
            components = URLComponents(string: Constants.baseURL + "/recipes/complexSearch")
            if let query = query {
                queryItems.append(URLQueryItem(name: "query", value: query))
            }
            if let maxFat = maxFat {
                queryItems.append(URLQueryItem(name: "maxFat", value: String(maxFat)))
            }
            if let number = number {
                queryItems.append(URLQueryItem(name: "number", value: String(number)))
            }
            if let diet = diet {
                queryItems.append(URLQueryItem(name: "diet", value: diet))
            }
            
        case .findByIngredients(let ingredients/*, let number*/):
            components = URLComponents(string: Constants.baseURL + "/recipes/findByIngredients")
            let ingredientList = ingredients.joined(separator: ",+").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            queryItems.append(URLQueryItem(name: "ingredients", value: ingredientList))
//            if let number = number {
//                queryItems.append(URLQueryItem(name: "number", value: String(number)))
//            }
            
        case .recipe(let id):
            components = URLComponents(string: Constants.baseURL + "/recipes/\(id)/information")
        }
    
        
        queryItems.append(URLQueryItem(name: "apiKey", value: Constants.API_KEY))
        components?.queryItems = queryItems
        
        return components?.url
    }
    
    private var httpMethod: String {
        return HTTP.Method.get.rawValue
    }
    
    private var httpBody: Data? {
        return nil
    }
}

extension URLRequest {
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .complexSearch, .findByIngredients, .recipe:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
        }
    }
}






