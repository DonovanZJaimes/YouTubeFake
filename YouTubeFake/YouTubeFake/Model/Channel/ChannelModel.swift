//
//  ChannelModel.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 21/02/24.
//

import Foundation

// MARK: - ChannelModel
struct ChannelModel: Codable {
    let kind: String
    let etag: String
    let pageInfo: PageInfo
    let items: [ItemsChannel]
    
    // MARK: - PageInfo
    struct PageInfo: Codable {
        let totalResults: Int
        let resultsPerPage: Int
    }
}
