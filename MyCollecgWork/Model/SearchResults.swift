//
//  SearchResults.swift
//  SearchPhotos
//
//  Created by Нургазы Адилет on 03.06.2024.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue:String]
    
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
