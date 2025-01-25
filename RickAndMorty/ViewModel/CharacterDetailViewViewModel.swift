//
//  CharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 25.01.2025.
//

final class CharacterDetailViewViewModel {
    private let character: Characters
    
    init(character: Characters) {
        self.character = character
    }
    public var title: String {
        character.name.uppercased()
    }
}
