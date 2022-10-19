//
//  SectionDetails.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 19.10.2022.
//

import UIKit

struct SectionDetailsVideo: Section {
    
    // MARK: - Properties
    var numberOfItems = 1
    
    // MARK: - Methods
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.leading = 4
        item.contentInsets.trailing = 4
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .none
        
        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SectionVideoDetailsCell.self), for: indexPath)
        return cell
    }
}
