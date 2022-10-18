//
//  MainViewController+UICollectionViewDataSource.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import UIKit

extension MainViewController: UICollectionViewDataSource {
    
    // MARK: - DataSource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    /// The collection view calls this method before adding a cell to its content.
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        sectionCell(willDisplay: cell, cellForItemAt: indexPath)
    }
    
    // MARK: - Private Help Methods
    private func sectionCell(willDisplay cell: UICollectionViewCell, cellForItemAt indexPath: IndexPath) {
        guard let cell = cell as? SectionVideoCell else {
            print("ERROR: Can't cell to SectionVideoCell")
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let videoCoreData = self.videos[indexPath.row]
            cell.configure(video: videoCoreData)
        }
    }
}
