//
//  RequestResultModel.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 16.02.2022.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let likes: Int
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

struct User: Decodable {
    let id: String
    let username: String
    let name: String
}
