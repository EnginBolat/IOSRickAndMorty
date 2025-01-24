//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 25.01.2025.
//

import Foundation
import UIKit

final class CharacterListViewViewModel: NSObject {
    func fetchCharacters() {
        let request = Request(endpoint: .character)
        
        Service.shared.executeRequest(request, expecting: Characters.self, complete: { result in
            switch result {
            case .success(let res):
                print("Total:", String(res.info.count))
                print("Page Result Count:", String(res.results.count))
                break
            case .failure(let err):
                print(String(describing: err))
                break
            }
        })
    }
}

extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemCyan
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize (width: width, height: width * 1.5)
    }
}
