//
//  MainViewController+UICollectionViewDelegate.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import UIKit

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = collectionView.cellForItem(at: indexPath) else { return }
        guard let sectionVideoCell = selectedItem as? SectionVideoCell else { return }
        guard let video = sectionVideoCell.video else { return }
        showDetailsViewController(video: video)
    }
    
    /// - Tag: highlight
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            // Transform animation
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            }, completion: nil)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            // Transform animation
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
}
