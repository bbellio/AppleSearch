//
//  SearchResult.swift
//  AppleSearch
//
//  Created by Bethany Wride on 10/3/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation

// MARK: - Music Search
struct MusicTopLevelDictionary: Decodable {
    let results: [MusicSearchResult]
}

struct MusicSearchResult: Decodable {
    let artistName: String
    let trackName: String?
    let artworkUrl100: String?
}

// MARK: - App Search
struct AppTopLevelDictionary: Decodable {
    let results: [AppSearchResult]
}

struct AppSearchResult: Decodable {
    let trackName: String
    let description: String
    let artworkUrl100: String?
}
