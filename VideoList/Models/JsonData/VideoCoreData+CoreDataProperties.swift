//
//  VideoCoreData+CoreDataProperties.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import UIKit
import CoreData

extension VideoCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VideoCoreData> {
        return NSFetchRequest<VideoCoreData>(entityName: "VideoCoreData")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: UIImage?
    @NSManaged public var releaseDate: String?
    @NSManaged public var url: URL?
    @NSManaged public var urlImage: URL?
    @NSManaged public var username: String?
    @NSManaged public var videoName: String?

}

extension VideoCoreData: Identifiable {
}
