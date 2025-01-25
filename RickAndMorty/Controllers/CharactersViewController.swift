//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 24.01.2025.
//

import UIKit

final class CharactersViewController: UIViewController, CharacterListViewDelegate {
    private let characterListView = CharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        layout()
    }
}


extension CharactersViewController {
    private func layout() {
        characterListView.delegate = self
        view.addSubview(characterListView)
        
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func characterListView(_ characterListView: CharacterListView, didSelectCharacter character: Characters) {
        let viewModel = CharacterDetailViewViewModel(character: character)
        let detailVC = CharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
