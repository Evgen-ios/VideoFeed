//
//  VideoPlayerManager.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 19.10.2022.
//
// https://www.hackingwithswift.com/forums/swift/avplayer-streaming-from/6431

import AVKit
import Cache

class VideoPlayerManager {
    
    public static let shared = VideoPlayerManager()

    private var player: AVPlayer!
    let diskConfig = DiskConfig(name: "DiskCache")
    let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)

    lazy var storage: Cache.Storage<String, Data>? = {
        return try? Cache.Storage(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forData())
    }()

    /// Plays a video either from the network if it's not cached or from the cache.
    func play(with url: URL) -> AVPlayer {
        let playerItem: CachingPlayerItem
        do {
            let result = try storage!.entry(forKey: url.absoluteString)
            // The video is cached.
            playerItem = CachingPlayerItem(data: result.object, mimeType: "video/mp4", fileExtension: "m4v")
        } catch {
            // The video is not cached.
            playerItem = CachingPlayerItem(url: url)
        }

        playerItem.delegate = self
        self.player = AVPlayer(playerItem: playerItem)
        self.player.automaticallyWaitsToMinimizeStalling = false
        self.player.play()
        return self.player
    }
    
    func download( with url: URL) {
        
    }

}

// MARK: - CachingPlayerItemDelegate
extension VideoPlayerManager: CachingPlayerItemDelegate {
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        // Video is downloaded. Saving it to the cache asynchronously.
        storage?.async.setObject(data, forKey: playerItem.url.absoluteString, completion: { _ in })
    }
}
