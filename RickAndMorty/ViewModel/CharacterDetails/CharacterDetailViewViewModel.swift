//
//  CharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 25.01.2025.
//

import Foundation
import UIKit

final class CharacterDetailViewViewModel {
    private let character: Characters
    
    enum SectionType {
        case photo (viewModel: CharacterHeroImageCollectionViewViewModel)
        case information (viewModel: [CharacterInfoCollectionViewViewModel])
        case episodes (viewModel: [CharacterEpisodeCollectionViewViewModel])
    }
    
    public var sections: [SectionType] = []
    
    init(character: Characters) {
        self.character = character
        setupSections()
    }
    
    /**
    
     let status: CharacterStatus
     let species: String?
     let type: String?
     let gender: CharacterGender
     let origin: CharacterOrigin
     let location: SingleLocation
     let episode: [String]
     */
    
    private func setupSections() {
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string:character.image))),
            .information(viewModel: [
                .init(title: "Status", subtitle: character.status.text),
                .init(title: "Type", subtitle: character.type),
                .init(title: "Species", subtitle: character.species),
                .init(title: "Gender", subtitle: character.gender.rawValue),
                .init(title: "Origin", subtitle: character.origin.name),
                .init(title: "Location", subtitle: character.location.name),
                .init(title: "Created", subtitle: character.created),
                .init(title: "Total Episode", subtitle: String(character.episode.count)),
            ]),
            .episodes(viewModel: character.episode.compactMap({
                return CharacterEpisodeCollectionViewViewModel(episodeDataUrl: URL(string: $0))
            }))
        ]
    }
    
    private var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    public var episodeCount: Int {
        return character.episode.count
    }
    
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 10,
            trailing: 0
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.6)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1.0)
                )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 4,
            trailing: 2
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item,item]
        )
    
        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    public func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 2,
            bottom: 10,
            trailing: 2
        )
    
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
    
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

}
