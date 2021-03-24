//
//  FeaturedPlaylistsResponse.swift
//  Spotify
//
//  Created by MacBook on 3/1/21.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistsResponse
}

struct CategoryPlaylistsResponse: Codable {
    let playlists: PlaylistsResponse
}

struct PlaylistsResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let id: String
    let external_urls: [String: String]
}
