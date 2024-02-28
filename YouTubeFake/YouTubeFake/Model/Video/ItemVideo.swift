//
//  ItemVideo.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import Foundation

// MARK: - Item
struct ItemVideo: Decodable {
    let kind: String
    let id: String?
    let snippet: SnippetItem?
    let contentDetails: ContentDetailsItem?
    let statistics: StatisticsItem?
    
    
    enum CodingKeys: String, CodingKey {
        case kind
        case id
        case snippet
        case contentDetails
        case statistics
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.kind = try container.decode(String.self, forKey: .kind)
        
        if let id = try? container.decode(VideoId.self, forKey: .id){
            self.id = id.videoId
        }else{
            if let id = try? container.decode(String.self, forKey: .id){
                self.id = id
            }else{
                self.id = nil
            }
        }
        
        if let snippet = try? container.decode(SnippetItem.self, forKey: .snippet){
            self.snippet = snippet
        }else{
            self.snippet = nil
        }
        
        if let contentDetails = try? container.decode(ContentDetailsItem.self, forKey: .contentDetails){
            self.contentDetails = contentDetails
        }else{
            self.contentDetails = nil
        }
        
        if let statistics = try? container.decode(StatisticsItem.self, forKey: .statistics){
            self.statistics = statistics
        }else{
            self.statistics = nil
        }
        
        
        
    }
    
    struct VideoId: Decodable{
        let kind : String
        let videoId : String
    }
    
    
}
