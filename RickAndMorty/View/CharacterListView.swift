//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 25.01.2025.
//

import UIKit
import Foundation

protocol CharacterListViewDelegate: AnyObject {
    func characterListView(_ characterListView: CharacterListView,didSelectCharacter character: Characters)
}

final class CharacterListView: UIView {
    public weak var delegate: CharacterListViewDelegate?
    private let viewModel = CharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layout()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacters()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CharacterListView {
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }

    
    private func layout() {
        self.addSubviews(collectionView,spinner)
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension CharacterListView : CharacterListViewViewModelDelegate {
    func didSelectCharacter(_ character: Characters) {
        delegate?.characterListView(self, didSelectCharacter: character)
    }
    
    func didLoadInitialCharacters() {
        collectionView.reloadData()
        self.spinner.stopAnimating()
        self.collectionView.isHidden = false
        UIView.animate(withDuration: 0.4) { self.collectionView.alpha = 1 }
    }
    
    
}
