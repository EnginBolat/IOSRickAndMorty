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
        detailsView.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
        switch section {
        case 0:
            return 1
        case 1:
            return 8
        case 2:
            return 20
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemPink
        
        if indexPath.section == 0 { cell.backgroundColor = .systemPink }
        else if indexPath.section == 1 { cell.backgroundColor = .blue }
        else { cell.backgroundColor = .green }
        
        return cell
    }
}
