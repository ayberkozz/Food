//
//  FoodService.swift
//  Food
//
//  Created by Ayberk Öz on 13.06.2023.
//

import Foundation

enum FoodServiceError: Error{
    case serverError(String = "Problem")
    case unknown(String = "An unknown error occured")
    case decodingError(String = "Error parsing server response")
}

protocol FoodServiceProtocol {
    func fetchFoods<T:Codable>(with endpoint: Endpoint,completion: @escaping (Result<T,FoodServiceError>)->Void)
}

class FoodService : FoodServiceProtocol {
    
    func fetchFoods<T:Codable>(with endpoint: Endpoint,completion: @escaping (Result<T,FoodServiceError>)->Void) {
        
        guard let request = endpoint.request else {return}
        
        URLSession.shared.dataTask(with: request) { data,response,err in
            
            if let error = err {
                completion(.failure(.unknown()))
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.serverError()))
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError()))
                }
            } else {
                completion(.failure(.unknown()))
            }
            
        }.resume()
    }
    
}
