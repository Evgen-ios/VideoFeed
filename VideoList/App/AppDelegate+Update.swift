//
//  AppDelegate+Update.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import Foundation

extension AppDelegate {
    /// Check app was start firs or not
    func firstRun() {
        let videos = CoreDataManager.shared.getVideos()
        
        if !notFirstRun || videos.count == 0 {
            getVideos {_ in}
            UserDefaults.standard.set(true, forKey: "notFirstLaunch")
        } else {
            print("Welcome back, Video count:", videos.count)
            for video in videos {
                print("ID:\(String(describing: video.id)) VideoName: \(String(describing: video.videoName))")
            }
        }
        
    }
    
    /// Get the videos from the server
    /// - Parameter completion: closure called when request is finished, with true if request is succesfull, and false if not
    func getVideos(completion: @escaping (_ success: Bool) -> Void) {
        
        let notificationName = "downloadedJson"
        
        NetworkManager.shared.getVideos() { jsonData in

            guard let videos = jsonData?.record.videos, !videos.isEmpty else {
                completion(false)
                return
            }
            
            for video in videos {
                print("ID:\(video.id) VideoName: \(video.videoName)")
                CoreDataManager.shared.appendVideo(video: video)
            }
            
            DispatchQueue.main.async {
                // Post notification with name
                NotificationCenter.default.post(
                    name: Notification.Name(notificationName),
                    object: nil
                )
                
                completion(true)
            }
        }
    }
}
