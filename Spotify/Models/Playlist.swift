//
//  Playlist.swift
//  Spotify
//
//  Created by Lazar Popovic on 2/28/21.
//

import Foundation

struct Playlist: Codable {
    let id: String
    let description: String
    let external_urls: [String: String]
    let images: [APIImage]
    let name: String
    let owner: User
}
