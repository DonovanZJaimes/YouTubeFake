//
//  SnippetItemsChanel.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 21/02/24.
//

import Foundation
// MARK: - Snippet
struct SnippetItemsChanel: Codable {
    let title : String
    let description : String
    let thumbnails: Thumbnails
    
    // MARK: - Thumbnails
    struct Thumbnails: Codable {
        let medium : Default
        let high: Default
        
        // MARK: - Default
        struct Default: Codable {
            let url: String
            let width : Int
            let height: Int
        }
    }
}
