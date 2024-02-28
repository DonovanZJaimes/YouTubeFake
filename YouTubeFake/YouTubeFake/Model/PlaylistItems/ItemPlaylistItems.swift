//
//  ItemPlaylistItems.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 21/02/24.
//

import Foundation

struct ItemPlaylistItems: Decodable{
    let kind : String
    let etag : String
    let id : String
    let snippet : SnippetItem
    let contentDetails : ContentDetails?
    
    struct ContentDetails: Decodable{
        let videoId : String?
        let videoPublishedAt : String?
    }
}
