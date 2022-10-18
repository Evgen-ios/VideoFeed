//
//  JsonData.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//


import Foundation

// MARK: - Videos
struct JsonData: Codable {
    let record: Record
    let metadata: Metadata
}

// MARK: - Metadata
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

// MARK: - Record
struct Record: Codable {
    let videos: [Video]
}

// MARK: - Video
struct Video: Codable {
    let id, username, releaseDate: String
    let url: String
}
