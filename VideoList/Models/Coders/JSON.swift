//
//  JSON.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import Foundation

struct JSON {
    /// Global JSON decoder
    static let decoder = { () -> JSONDecoder in
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }()
    
    /// Global JSON encoder
    static let encoder = { () -> JSONEncoder in
        let jsonEncoder = JSONEncoder()
        return jsonEncoder
    }()
}
