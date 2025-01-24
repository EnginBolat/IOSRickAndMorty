//
//  ServiceResponse.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 24.01.2025.
//

struct ServiceResponse<T: Codable> : Codable {
    let info : ServiceInfo
    let results : [T]
}

struct ServiceInfo : Codable {
    let count : Int
    let pages : Int
    let next : String
    let prev : String?
}
