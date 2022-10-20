//
//  AVPlayer+stop.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 20.10.2022.
//

import AVFoundation

extension AVPlayer {
    func stop(){
        self.seek(to: CMTime.zero)
        self.pause()
    }
}
