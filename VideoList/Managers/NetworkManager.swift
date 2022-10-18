//
//  NetworkManager.swift
//  VideoList
//
//  Created by Evgeniy Goncharov on 18.10.2022.
//

import Foundation

public class NetworkManager {
    // MARK: - Static Properties
    /// URL for getting videos from JSON
    internal static let url = URL(string: "https://api.jsonbin.io/v3/b/634e6d6f65b57a31e69a3a27")!
    
    /// Default shared instance of Network Manager
    public static let shared = NetworkManager()
    
    // MARK: - Private Methods
    /// Decode the data given with JSON
    /// - Parameter data: the data received from the server
    /// - Returns: decoded data as Codable type if success, nil in case of fail
    private func decode<T: Codable>(_ data: Data) -> T? {
        
        // Try to decode as value
        let decodedValue = try? JSON.decoder.decode(T.self, from: data)
        
        // If both failed show error message
        guard let decodedData = decodedValue else {
            let message = String(data: data, encoding: .utf8) ?? "Unknown data format"
            print(#file, #line, "ERROR decoding \(message)")
            return nil
        }
        
        return decodedData
    }
    
    /// Send get request and call completion when done
    /// - Parameters:
    ///   - completion: closure called after request is finished, with data if successfull, or with nil if not
    private func get<T: Codable>(completion: @escaping (T?) -> Void) {
        
        var request = URLRequest(url: NetworkManager.url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            // Check for self availability
            guard let self = self else {
                print(#file, #line, "ERROR: self is not available")
                completion(nil)
                return
            }
            
            // Check if we haven't received nil
            guard let data = data else {
                let message = error?.localizedDescription ?? "No data"
                print(#file, #line, "ERROR requesting \(request): \(message)")
                completion(nil)
                return
            }
            
            // Decode the received data
            guard let decodedData: T = self.decode(data) else {
                print (#file, #line, "ERROR decoding response to \(request) \(data)")
                completion(nil)
                return
            }
            
            completion(decodedData)
        }
        
        task.resume()
    }
    
    // MARK: - Methods
    /// Call videos API
    /// - Parameter completion: closure called after the request is finished, with JSON data if successfull, or with nil if not
    func getVideos(completion: @escaping (_ jsonData: JsonData?) -> Void) {
        get(completion: completion)
    }
}
