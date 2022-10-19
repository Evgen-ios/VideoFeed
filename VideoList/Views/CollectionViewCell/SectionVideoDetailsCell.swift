//
//  SectionVideoDetailsCell.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 19.10.2022.
//

import UIKit

class SectionVideoDetailsCell: UICollectionViewCell {
    
    // MARK: - Properties
    weak var video: VideoCoreData?
    
    // MARK: - Outlets
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var uiViewVideo: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var videoName: UILabel!
    
    // MARK: - Inherited Methods
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helper Methods
    func configure(video: VideoCoreData) {
        self.video = video
        DispatchQueue.main.async {
            self.userName.text = video.username
            self.videoName.text = video.videoName
            self.configureDate(dateTime: video.releaseDate)
        }
    }
    
    // MARK: - Helper Methods
    func configureDate(dateTime: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        print(dateTime)
        guard let date = dateFormatter.date(from: dateTime) else { return }
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        print("Текущее время: \(hour):\(minute):\(second)")
        
        self.date.text = "\(year)-\(month)-\(day)"
        self.time.text = "\(hour):\(minute)"
    }

}
