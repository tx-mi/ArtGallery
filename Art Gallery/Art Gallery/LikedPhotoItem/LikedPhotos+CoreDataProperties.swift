//
//  LikedPhotos+CoreDataProperties.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 10.05.2022.
//
//

import Foundation
import CoreData


extension LikedPhotos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedPhotos> {
        return NSFetchRequest<LikedPhotos>(entityName: "LikedPhotos")
    }

    @NSManaged public var id: String
    @NSManaged public var unsplashPhoto: Data?

}

extension LikedPhotos : Identifiable {

}
