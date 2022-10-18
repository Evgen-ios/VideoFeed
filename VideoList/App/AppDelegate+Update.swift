//
//  AppDelegate+Update.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import Foundation

extension AppDelegate {
    /// Get the videos from the server
    /// - Parameter completion: closure called when request is finished, with true if request is succesfull, and false if not
    func getVideos(completion: @escaping (_ success: Bool) -> Void) {
        
        let notificationName = "downloadedJson"
        
        NetworkManager.shared.getVideos() { jsonData in

            guard let videos = jsonData?.record.videos, !videos.isEmpty else {
                completion(false)
                return
            }
            
            print("INFO: Successful loaded \(videos.count) videos")
            
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
