//
//  CharacterCollectionViewModel.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 25.01.2025.
//

import Foundation

final class CharacterCollectionViewModel {
    public let characterName: String
    private let  characterStatus: CharacterStatus
    private let characterImageUrl: URL?
    
    init(characterName: String, characterStatus: CharacterStatus, characterImageUrl: URL? = nil) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping(Result<Data,Error>) ->Void ){
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url:url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
