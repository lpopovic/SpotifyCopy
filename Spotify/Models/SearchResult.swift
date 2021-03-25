//
//  SearchResult.swift
//  Spotify
//
//  Created by Lazar Popovic on 3/24/21.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
