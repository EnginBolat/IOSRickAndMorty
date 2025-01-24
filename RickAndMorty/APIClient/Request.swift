//
//  Request.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 24.01.2025.
//

import Foundation

final class Request {
    struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    let endpoint : Endpoint
    let pathComponents: [String]
    let queryItems: [URLQueryItem]
    
    public var url: String? {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryItems.isEmpty {
            string += "?"
            let argumentString = queryItems.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
        }
        
        return string
    }
    
    public init(endpoint: Endpoint, pathComponents: [String] = [], queryItems: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryItems = queryItems
    }
}
