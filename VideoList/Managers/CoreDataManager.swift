//
//  CoreDataManager.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import CoreData
import UIKit

public class CoreDataManager {
    
    // MARK: - Properties
    static let shared = CoreDataManager()
    
    // MARK: - Core Data
    var persistentContainer: NSPersistentContainer = {
        
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))
        
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
    
    // MARK: - Helper Methods
    /// Add category into CoreData
    /// - Parameter category: Category
    func appendVideo(video: Video) {
        let videoCoreData = VideoCoreData(context: viewContext)
        
        guard someEntityExists(entityName: VideoCoreData.className, with: video.id) else {
            print("False")
            return
        }
        
        videoCoreData.id = video.id
        videoCoreData.username = video.username
        videoCoreData.releaseDate = video.releaseDate
        videoCoreData.url = URL(string: video.url)
        videoCoreData.urlImage = URL(string: video.urlImage)
        videoCoreData.videoName = video.videoName
        
        downloadImage(url: videoCoreData.urlImage) {data in
            videoCoreData.image = UIImage(data: data)
            try? self.viewContext.save()
        }
        
    }
    
    /// Download image into CoreData
    /// - Parameters:
    ///   - url: URL image
    ///   - categoryCoreData: CoreData name
    func downloadImage(url: URL?, completion: @escaping(Data) -> ())
    {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                completion(data)
            }
            
        }.resume()
    }
    
    /// Get video sorted with name
    ///  - Returns: return [T]
    /// - Parameter sorted: sorted by name
    func getCoreData<T: NSManagedObject>(object: AnyClass ,sorted: Bool? = false) -> [T] {
        
        guard let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as? NSFetchRequest<T> else {
            print("ERROR: Can't cast to NSFetchRequest")
            return []
        }
        
        if sorted ?? false {
            // Sorted by name
            let sort = NSSortDescriptor(key: "username", ascending: true)
            fetchRequest.sortDescriptors = [sort]
        }
        
        let sort = NSSortDescriptor(key: "username", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        guard let coreData = try? viewContext.fetch(fetchRequest) else {
            print("ERROR: Can't get categoryCoreData")
            return []
        }
        
        return coreData
    }
    
    ///  Get category sorted with name
    /// - Returns: return [VideoCoreData]
    func getVideos() -> [VideoCoreData] {
        let fetchRequest: NSFetchRequest<VideoCoreData> = VideoCoreData.fetchRequest()
        let sort = NSSortDescriptor(key: "videoName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        guard let videoCoreData = try? viewContext.fetch(fetchRequest) else {
            print("ERROR: Can't get categoryCoreData")
            return []
        }
        
        return videoCoreData
    }
    
    /// Check object by id from CoreData
    /// - Parameters:
    ///   - entityName: entity name into CoreData
    ///   - id: id object into CoreData, but it not objectID
    /// - Returns: true if object by ID found or false if not
    func someEntityExists(entityName: String, with id: String) -> Bool {
        // Make a fetch request with entity name
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        // Make a predicate for filter object by ID, not objectID
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate
        
        guard let results = try? viewContext.fetch(fetchRequest) as? [NSManagedObject] else {
            print("ERROR: Executing fetch request")
            return false
        }
        
        return results.count == .zero
    }
}
