//
//  MainViewController+Actions.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 19.10.2022.
//

import UIKit

extension MainViewController {
    
    // MARK: - Methods
    func showDetailsViewController(video: VideoCoreData) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "detailesViewController")
        
        guard let detailesViewController = viewController as? DetailsViewController else {
            print("ERROR: Can't cast viewController to ", DetailsViewController.className)
            return
        }
        
        detailesViewController.video = video
        
        show(viewController, sender: nil)
    }
}
