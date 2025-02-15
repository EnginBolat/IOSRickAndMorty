//
//  CharacterHeroImageCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 15.02.2025.
//

import UIKit

class CharacterHeroImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "CharacterHeroImageCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
               imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
               imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor), // Hata burada düzeltilmiş
           ])
    }
    
    public func configure (with viewModel: CharacterHeroImageCollectionViewViewModel){
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print("Fail on CharacterHeroImageViewCell: \(error)")
                break
            }
        }
    }
}
