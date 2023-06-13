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
    func fetchFoods(with endpoint: Endpoint,completion: @escaping (Result<[FoodDetailModel],FoodServiceError>)->Void)
}

class FoodService {
    
    func fetchFoods(with endpoint: Endpoint,completion: @escaping (Result<[FoodDetailModel],FoodServiceError>)->Void) {
        
        guard let request = endpoint.request else {return}
        
        URLSession.shared.dataTask(with: request) { data,response,err in
            
            if let error = err {
                completion(.failure(.unknown(error.localizedDescription)))
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.decodingError()))
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let foodData = try decoder.decode(FoodModel.self, from: data)
                    completion(.success(foodData.results))
                } catch let errr {
                    completion(.failure(.decodingError(errr.localizedDescription)))
                    print(errr.localizedDescription)
                }
            } else {
                completion(.failure(.unknown()))
            }
            
        }.resume()
    }
    
}
