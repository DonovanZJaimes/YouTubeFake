//
//  VideoModel.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import Foundation

// MARK: - VideoModel
struct VideoModel: Decodable {
    let kind, etag: String
    let items: [ItemVideo]
    let pageInfo: PageInfoVideo
    
    
    // MARK: - PageInfo
    struct PageInfoVideo: Codable {
        let totalResults: Int
        let resultsPerPage: Int
    }

}
