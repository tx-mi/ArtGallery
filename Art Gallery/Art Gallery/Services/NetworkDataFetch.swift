//  NetworkDataFetch.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 16.02.2022.
//

import Foundation

class NetworkDataFetch {
    
    var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(searchTerm: searchTerm) { data, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
            
            let objects = self.decodeJSON(T: SearchResults.self, from: data)
            completion(objects)
        }
    }
    
    func decodeJSON<T: Decodable>(T: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(T.self, from: data)
            return objects
        } catch let error {
            print("Failed to decode JSON", error)
            return nil
        }
    }
}
