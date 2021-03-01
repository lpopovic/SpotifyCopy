//
//  Artist.swift
//  Spotify
//
//  Created by MacBook on 2/28/21.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
