//
//  VideoDataJson.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import Foundation

// MARK: - VideoDataJson
struct VideoModel: Codable {
    let record: Record
    let metadata: Metadata
}

struct Metadata: Codable {
    let id: String
    let metadataPrivate: Bool
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case metadataPrivate = "private"
        case createdAt
    }
}

struct Record: Codable {
    let videos: [Video]
}

struct Video: Codable {
    let id: String
    let releaseDate: String
    let url: String
    let urlImage: String
    let username: String
    let videoName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case releaseDate
        case url
        case urlImage
        case username
        case videoName
    }
    
}
