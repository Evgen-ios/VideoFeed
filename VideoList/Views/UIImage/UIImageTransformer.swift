//
//  UIImageTransformer.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//
//  https://github.com/azamsharp/SavingImagesCoreData

import UIKit

class UIImageTransformer: ValueTransformer {
    
    // MARK: - Inherited Methods
    override func transformedValue(_ value: Any?) -> Any? {
        
        guard let image = value as? UIImage else {
            print("ERROR: Can't cast value to UIImage")
            return nil
        }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        
        guard let data = value as? Data else {
            print("ERROR: Can't cast value to UIImage")
            return nil
        }
        
        do {
            let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
            return image
        } catch {
            return nil
        }
        
    }
    
}
