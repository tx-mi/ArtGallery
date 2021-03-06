//
//  RequestResultModel.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 16.02.2022.
//

import Foundation

struct UnsplashPhoto: Codable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let downloads: Int
    let location: Location?
    let user: User
    let urls: [URLKind.RawValue:String]
    
    
    enum URLKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct Location: Codable {
    let name: String?
}

struct User: Codable {
    let id: String
    let username: String
    let name: String
}
