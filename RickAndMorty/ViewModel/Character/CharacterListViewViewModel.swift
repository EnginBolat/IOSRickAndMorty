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
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectCharacter(_ character: Characters)
}

final class CharacterListViewViewModel: NSObject {
    public weak var delegate: CharacterListViewViewModelDelegate?
    private var apiInfo: ServiceResponse<Characters>.Info? = nil
    private var isLoadingMoreCharacters = false
    
    private var characters: [Characters] = [] {
        didSet {
            for character in characters {
                   let viewModel = CharacterCollectionViewModel(
                    characterName: character.name,
                       characterStatus: character.status,
                       characterImageUrl: URL(string: character.image)
                   )
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel)
                }
               }
           }
    }
    private var cellViewModels : [CharacterCollectionViewModel] = []
    
    public func fetchCharacters() {
        let request = Request(endpoint: .character)
        Service.shared.executeRequest(request, expecting: ServiceResponse<Characters>.self, complete: { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.characters = results
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
    
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        
        self.isLoadingMoreCharacters = true
        guard let request = Request(url: url) else {
            isLoadingMoreCharacters = false
            print("Failed to create request")
            return
        }
    
        Service.shared.executeRequest(request, expecting: ServiceResponse<Characters>.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let success):
                let moreResults = success.results
                let info = success.info
                self?.apiInfo = info
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = originalCount + moreResults.count
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = (startingIndex..<(startingIndex + newCount)).map {
                    IndexPath(row: $0, section: 0)
                }

                strongSelf.characters.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    self?.delegate?.didLoadMoreCharacters(with: indexPathsToAdd)
                }
                self?.isLoadingMoreCharacters = false
            case .failure(let err):
                print(String(describing: err))
                self?.isLoadingMoreCharacters = false
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, shouldShowLoadMoreIndicator, let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: FooterLoadingCollectionReusableView.indetifier,
            for: indexPath
        ) as? FooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width,
                      height: 100)
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
        guard shouldShowLoadMoreIndicator,
              !cellViewModels.isEmpty,
              !isLoadingMoreCharacters,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
                self?.fetchAdditionalCharacters(url: url)
            }
            
            t.invalidate()
        }
    }
}
