//
//  Album.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 04/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

// MARK: - AlbumRootObject

struct AlbumRootObject: Codable {
    
    let albums: Albums
}

// MARK: - Albums

struct Albums: Codable {
    
    let href: String
    
    let items: [Item]
    
    let limit: Int
    
    let next: String
    
    let offset: Int
    
    let previous: String?
    
    let total: Int
}

// MARK: - Item

struct Item: Codable {
    
    let albumType: AlbumTypeEnum
    
    let artists: [Artist]
    
    let availableMarkets: [String]
    
    let externalUrls: ExternalUrls
    
    let href: String
    
    let id: String
    
    let images: [Image]
    
    let name, releaseDate: String
    
    let releaseDatePrecision: ReleaseDatePrecision
    
    let totalTracks: Int
    
    let type: AlbumTypeEnum
    
    let uri: String

    enum CodingKeys: String, CodingKey {
        
        case albumType = "album_type"
        
        case artists
        
        case availableMarkets = "available_markets"
        
        case externalUrls = "external_urls"
        
        case href, id, images, name
        
        case releaseDate = "release_date"
        
        case releaseDatePrecision = "release_date_precision"
        
        case totalTracks = "total_tracks"
        
        case type, uri
    }
}

enum AlbumTypeEnum: String, Codable {
    
    case album = "album"
    
    case single = "single"
}

// MARK: - Artist

struct Artist: Codable {
    
    let externalUrls: ExternalUrls
    
    let href: String
    
    let id, name: String
    
    let type: ArtistType
    
    let uri: String

    enum CodingKeys: String, CodingKey {
        
        case externalUrls = "external_urls"
        
        case href, id, name, type, uri
    }
}

// MARK: - ExternalUrls

struct ExternalUrls: Codable {
    
    let spotify: String
}

enum ArtistType: String, Codable {
    
    case artist = "artist"
}

// MARK: - Image

struct Image: Codable {
    
    let height: Int
    
    let url: String
    
    let width: Int
}

enum ReleaseDatePrecision: String, Codable {
    
    case day = "day"
}
