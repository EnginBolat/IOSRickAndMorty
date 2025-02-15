//
//  CharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 15.02.2025.
//

import UIKit

class CharacterInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "CharacterInfoCollectionViewCell"
    
    private var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private var subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private var icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "globe.americas")
        return icon
    }()
    
    private var titleContainer: UIView = {
        let container = UIImageView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .secondarySystemBackground
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        titleContainer.addSubview(title)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        subtitle.text = nil
        icon.image = nil
    }
    
    private func setupConstraints() {
        contentView.addSubviews(subtitle,titleContainer, icon)
        let leftSpacing = contentView.bounds.width / 8
        
        NSLayoutConstraint.activate([
            titleContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            title.leftAnchor.constraint(equalTo: titleContainer.leftAnchor),
            title.rightAnchor.constraint(equalTo: titleContainer.rightAnchor),
            title.topAnchor.constraint(equalTo: titleContainer.topAnchor),
            title.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor),
            
            icon.widthAnchor.constraint(equalToConstant: 32),
            icon.heightAnchor.constraint(equalToConstant: 32),
            icon.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 35),
            icon.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: leftSpacing),
            
            subtitle.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: leftSpacing),
            subtitle.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            subtitle.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 35),
            subtitle.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    public func configure (with viewModel: CharacterInfoCollectionViewViewModel){
        self.title.text = viewModel.title
        self.subtitle.text = viewModel.subtitle
    }
}
