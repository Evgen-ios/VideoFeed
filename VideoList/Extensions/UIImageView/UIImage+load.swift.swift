//
//  UIImage+load.swift.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 19.10.2022.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    // Check for self availability
                    guard let self = self else {
                        print("ERROR: self is not available")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
