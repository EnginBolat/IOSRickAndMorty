//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 25.01.2025.
//

import Foundation
import UIKit

protocol CharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: Characters)
}

final class CharacterListViewViewModel: NSObject {
    public weak var delegate: CharacterListViewViewModelDelegate?
    private var apiInfo: ServiceResponse<Characters>.Info? = nil
    
    private var characters: [Characters] = [] {
        didSet {
               for character in characters {
                   let viewModel = CharacterCollectionViewModel(
                       characterName: character.name,
                       characterStatus: character.status,
                       characterImageUrl: URL(string: character.image)
                   )
                   cellViewModels.append(viewModel)
               }
           }
    }
    private var cellViewModels : [CharacterCollectionViewModel] = []
    
    public func fetchCharacters() {
        let request = Request(endpoint: .character)
        Service.shared.executeRequest(request, expecting: Characters.self, complete: { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.characters = results
                let info = responseModel.info
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
                break
            case .failure(let err):
                print(String(describing: err))
                break
            }
        })
    }
    
    public func fetchAdditionalCharacters() {
        
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize (width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

/// MARK - Scrollview

extension CharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator else { return }
        
    }
}
