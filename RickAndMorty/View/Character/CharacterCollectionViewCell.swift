//
//  CharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 25.01.2025.
//

import UIKit

/// Single cell for character
final class CharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .label
        nameLabel.font = .systemFont(ofSize: 18,
                                     weight: .medium)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.textColor = .secondaryLabel
        statusLabel.font = .systemFont(ofSize: 16,
                                       weight: .regular)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    // MARK: - Init
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView,nameLabel,statusLabel)
        addConstraints()
        
        contentView.layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
           
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor,constant: -3),
        ])
    }
    
    internal override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel: CharacterCollectionViewModel){
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data:data)
                    self?.imageView.image = image
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
