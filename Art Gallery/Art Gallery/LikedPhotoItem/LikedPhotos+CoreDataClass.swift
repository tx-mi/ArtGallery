//
//  LikedPhotos+CoreDataClass.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 10.05.2022.
//
//

import Foundation
import UIKit
import CoreData

@objc(LikedPhotos)
public class LikedPhotos: NSManagedObject {
    func convertToData(photo: UnsplashPhoto) -> Data? {
        var data: Data? = nil
        do {
            data = try JSONEncoder().encode(photo)
        } catch let error as NSError {
            print("Could not encode to data. \(error) \(error.userInfo)")
        }
        return data
    }
    
    func convertToUnsplashPhoto(photok: Data?) -> UnsplashPhoto? {
        var photo: UnsplashPhoto? = nil
        photo = NetworkDataFetch().decodeJSON(T: UnsplashPhoto.self, from: photok)
        return photo
    }
    
    func getAllItems() -> [LikedPhotos] {
        var items: [LikedPhotos] = []
        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return items
        }
        
        do {
            items =  try managedContext.fetch(LikedPhotos.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error) \(error.userInfo)")
        }
        return items
    }
}
