//
//  CharacterStatus.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 24.01.2025.
//

enum CharacterStatus : String, Codable{
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
