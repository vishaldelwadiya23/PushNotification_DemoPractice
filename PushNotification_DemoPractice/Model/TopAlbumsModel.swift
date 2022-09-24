//
//  TopAlbumsModel.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 23/09/22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)


// MARK: - Welcome
struct TopAlbumsModel: Decodable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Decodable {
    let title: String
    let id: String
    let author: Author
    let links: [Link]
    let copyright, country: String
    let icon: String
    let updated: String
    let results: [Result]
}

// MARK: - Author
struct Author: Decodable {
    let name: String
    let url: String
}

// MARK: - Link
struct Link: Decodable {
    let linkSelf: String

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
    }
}

// MARK: - Result
struct Result: Decodable {
    let artistName, id, name, releaseDate: String
    let kind: Kind
    let artistID: String?
    let artistURL: String?
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
    let contentAdvisoryRating: ContentAdvisoryRating?

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate, kind
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url, contentAdvisoryRating
    }
}

enum ContentAdvisoryRating: String, Decodable {
    case explict = "Explict"
}

// MARK: - Genre
struct Genre: Decodable {
    let genreID, name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}

enum Kind: String, Decodable {
    case albums = "albums"
}
