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
            string += argumentString
        }
        return string
    }
    
    public init(endpoint: Endpoint, pathComponents: [String] = [], queryItems: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryItems = queryItems
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/"){
            let components = trimmed.split(separator: "/")
            if !components.isEmpty {
                let endpointString = String(components[0])
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components.dropFirst().map { String($0) }
                }
                if let rmEndpoint = Endpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint,pathComponents: pathComponents)
                    return
                }
            }
        
        } else if trimmed.contains("?"){
            let components = trimmed.split(separator: "?")
            if !components.isEmpty, components.count >= 2{
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else { return nil }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })
                if let rmEndpoint = Endpoint(rawValue: String(endpointString)) {
                    self.init(endpoint: rmEndpoint, queryItems: queryItems)
                    return
                }
            }
        }
        return nil
        
    }
}
