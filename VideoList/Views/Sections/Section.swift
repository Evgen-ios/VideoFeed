//
//  Section.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import UIKit

protocol Section {
    // MARK: - Properties
    var numberOfItems: Int { get }
    
    // MARK: - Methods
    func layoutSection() -> NSCollectionLayoutSection
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}
