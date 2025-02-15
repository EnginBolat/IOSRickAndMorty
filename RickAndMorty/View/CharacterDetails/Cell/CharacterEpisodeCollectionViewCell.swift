//
//  CharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 15.02.2025.
//

import UIKit

class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "CharacterEpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupConstraints() {
        
    }
    
    public func configure (with viewModel: CharacterEpisodeCollectionViewViewModel){
        
    }
}
