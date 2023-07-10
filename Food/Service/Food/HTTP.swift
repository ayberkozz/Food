//
//  HTTP.swift
//  Food
//
//  Created by Ayberk Öz on 13.06.2023.
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get = "GET"
    }
    
    enum Headers {
        
        enum Key: String {
            case contentType = "Content-Type"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
        
    }
}
