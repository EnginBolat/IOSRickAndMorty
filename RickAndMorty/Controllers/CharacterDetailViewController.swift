//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 25.01.2025.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    private let viewModel: CharacterDetailViewViewModel
    
    
    init(viewModel: CharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
}
