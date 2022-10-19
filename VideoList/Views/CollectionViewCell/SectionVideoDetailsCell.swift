//
//  SectionVideoDetailsCell.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 19.10.2022.
//

import UIKit
import AVKit


class SectionVideoDetailsCell: UICollectionViewCell {
    
    // MARK: - Properties
    weak var video: VideoCoreData?
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!
    
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
            self.configureVideo(videoUrl: video.url)
        }
    }
    
    // MARK: - Helper Methods
    func configureDate(dateTime: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateTime) else { return }
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        self.date.text = "\(year)-\(month)-\(day)"
        self.time.text = "\(hour):\(minute)"
    }
    
    func configureVideo(videoUrl: URL?){
        guard let videoUrl else { return }
        
        let videoPlayerWorker = VideoPlayerManager.shared
        player = videoPlayerWorker.play(with: videoUrl)
        
        //player = AVPlayer(playerItem: playerItem)
        self.playerViewController = AVPlayerViewController()
        playerViewController.player = self.player
        player.automaticallyWaitsToMinimizeStalling = true
        
        guard self.uiViewVideo != nil else { return }
        
        playerViewController.view.frame = self.uiViewVideo.frame
        playerViewController.player?.pause()
        self.uiViewVideo.addSubview(playerViewController.view)
    }
    
}
