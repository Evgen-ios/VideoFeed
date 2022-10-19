//
//  SectionVideoCell.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import UIKit

class SectionVideoCell: UICollectionViewCell {
    
    // MARK: - Properties
    var video: VideoCoreData?
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Inherited Methods
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helper Methods
    func configure(video: VideoCoreData) {
        self.video = video
        DispatchQueue.main.async {
            self.imageView.image = video.image
            self.imageView.layer.cornerRadius = 15
            self.titleLabel.text = video.username
        }
    }
    
}
