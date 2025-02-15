//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 25.01.2025.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    private let viewModel: CharacterDetailViewViewModel
    private let detailsView:  CharacterDetailView
    
    
    init(viewModel: CharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailsView = CharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapshare))
        commonInit()
        detailsView.collectionView?.delegate = self
        detailsView.collectionView?.dataSource = self
        detailsView.collectionView?.register(CharacterHeroImageCollectionViewCell.self, forCellWithReuseIdentifier: CharacterHeroImageCollectionViewCell.identifier)
        detailsView.collectionView?.register(CharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterInfoCollectionViewCell.identifier)
        detailsView.collectionView?.register(CharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: CharacterEpisodeCollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
}

// MARK: LOGIC

extension CharacterDetailViewController {
    private func commonInit() {
        view.backgroundColor = .systemBackground
        addConstraions()
    }
    
    @objc private func didTapshare() {
        // Share character info
    }
}

// MARK: LAYOUT

extension CharacterDetailViewController {
    private func addConstraions() {
        view.addSubview(detailsView)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
            
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterHeroImageCollectionViewCell.identifier,
                for: indexPath
            ) as? CharacterHeroImageCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
            
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterInfoCollectionViewCell.identifier,
                for: indexPath
            ) as? CharacterInfoCollectionViewCell else { fatalError() }
            cell.configure(with: viewModels[indexPath.row])
            return cell
            
            
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterEpisodeCollectionViewCell.identifier,
                for: indexPath
            ) as? CharacterEpisodeCollectionViewCell else { fatalError() }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    
}

