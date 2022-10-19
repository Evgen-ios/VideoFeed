//
//  ViewController.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Lazy Properties
    lazy var videos = CoreDataManager.shared.getVideos()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: String(describing: SectionVideo.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SectionVideoCell.self))
        
        return collectionView
    }()
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        var sections = self.sections
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        return layout
    }()
    
    lazy var sections: [Section] = [
        configureSectionVideo()
    ]
    
    // MARK: - Helper Methods
    /// Configure
    /// - Returns: configure section
    func configureSectionVideo() -> SectionVideo {
        var sectionVideo = SectionVideo()
        sectionVideo.numberOfItems = videos.count
        return sectionVideo
    }
    
    public func configureLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        //configureSearchController()
        configureLayout()
    }
    
    
}

