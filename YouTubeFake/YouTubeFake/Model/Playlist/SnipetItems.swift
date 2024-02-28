//
//  SnipetItems.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import Foundation

// MARK: - SnipetItems
struct SnipetItems: Decodable {
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let localized: localized
    
    // MARK: - Thumbnails
    struct Thumbnails: Decodable {
        let medium: Medium
        
        struct Medium: Decodable {
            let url: String
            let width: Int
            let height: Int
        }
    }
    
    // MARK: - localized
    struct localized : Decodable {
        let title: String
        let description: String
    }
}
