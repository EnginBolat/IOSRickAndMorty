//
//  Characters.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 24.01.2025.
//

struct Characters : Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String?
    let type: String?
    let gender: CharacterGender
    let origin: CharacterOrigin
    let location: SingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

