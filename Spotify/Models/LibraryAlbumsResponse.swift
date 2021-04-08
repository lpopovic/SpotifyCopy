//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by MacBook on 4/8/21.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    struct AlbumResponse: Codable {
        let album: Album
    }
    let items: [AlbumResponse]
}

extension LibraryAlbumsResponse {
    func getAlbums() -> [Album] {
        return items.map({$0.album})
    }
}
