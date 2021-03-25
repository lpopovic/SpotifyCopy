//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Lazar Popovic on 3/1/21.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}

