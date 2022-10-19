//
//  DetailsViewController.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 19.10.2022.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    var video: VideoCoreData?
    
    // MARK: - Lazy Properties
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Register Section Cell
        collectionView.register(UINib(nibName: String(describing: SectionDetailsVideo.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SectionVideoDetailsCell.self))

        return collectionView
    }()
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        var sections = self.sections
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        
        return layout
    }()
    
    // Sections for CollectionView
    lazy var sections: [Section] = [
        configureSectionVideoDetails()
    ]
    
    // MARK: - Helper Methods
    /// Configure Layout
    private func configureLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    /// Configure
    /// - Returns: configure section
    private func configureSectionVideoDetails() -> SectionDetailsVideo {
        let sectionDetailsVideo = SectionDetailsVideo()
        return sectionDetailsVideo
    }
    
    // MARK: - Inherited Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        configureLayout()
    }
    
}
