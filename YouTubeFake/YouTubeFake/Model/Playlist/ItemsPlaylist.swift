//
//  ItemsPlaylist.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import Foundation

// MARK: - ItemsPlaylist
struct ItemsPlaylist: Decodable {
    let kind: String
    let etag: String
    let id: String
    let snippet: SnipetItems
    let contentDetails: ContentDetailsItems
    
    // MARK: - ContentDetailsItems
    struct ContentDetailsItems: Decodable {
        let itemCount: Int
    }
}







