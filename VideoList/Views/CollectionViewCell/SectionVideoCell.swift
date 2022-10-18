//
//  SectionVideoCell.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import UIKit

class SectionVideoCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Inherited Methods
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helper Methods
    func configure(video: VideoCoreData) {
        imageView.image = video.image
        titleLabel.text = video.username
    }
    
}