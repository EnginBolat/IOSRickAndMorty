//
//  CharacterHeroImageCollectionViewViewModel.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 15.02.2025.
//

import Foundation

final class CharacterHeroImageCollectionViewViewModel {
    let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping(Result<Data,Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageUrl,completion: completion)
    }
}
