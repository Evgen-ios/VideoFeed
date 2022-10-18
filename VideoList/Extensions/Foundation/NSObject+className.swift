//
//  NSObject+className.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import Foundation

extension NSObject {
    // MARK: - Static Properties
    /// Static property matching the name of the current class
    static var className: String { String(describing: Self.self) }
    
    // MARK: - Properties
    /// Property matching the name of the current class
    var className: String { String(describing: Self.self) }
}

