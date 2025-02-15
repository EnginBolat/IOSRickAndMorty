//
//  CharacterInfoCollectionViewViewModel.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 15.02.2025.
//

final class CharacterInfoCollectionViewViewModel {
    public var title: String
    public var subtitle: String?
    
    init(title: String,subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
    }
}
