//
//  ItemsChannel.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 21/02/24.
//

import Foundation

// MARK: - Items
struct ItemsChannel: Codable {
    let kind: String
    let etag: String
    let id: String
    let snippet: SnippetItemsChanel
    let statistics: Statistics?
    let brandingSettings : BrandingSettings?
    
    
    
    // MARK: - Statistics
    struct Statistics: Codable {
        let viewCount: String
        let subscriberCount: String
        let hiddenSubscriberCount: Bool
        let videoCount: String
    }
    
    struct BrandingSettings : Codable{
        let image: Image
        
        struct Image : Codable{
            let bannerExternalUrl : String
        }
    }
}
