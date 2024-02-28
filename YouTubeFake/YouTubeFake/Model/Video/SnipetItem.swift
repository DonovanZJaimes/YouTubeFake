//
//  SnipetItem.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import Foundation

// MARK: - Snippet
struct SnippetItem: Codable {
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let tags: [String]?

    
    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelId
        case title
        case description
        case thumbnails
        case channelTitle
        case tags
    }
    // thumbnails
    // MARK: - Thumbnails
    struct Thumbnails: Codable {
        let medium, high: Default?
        
        enum CodingKeys: String, CodingKey {
            case medium
            case high
        }
        
        // MARK: - Default
        struct Default: Codable {
            let url: String
            let width, height: Int
        }//Default
        
    }
}//Snippet
