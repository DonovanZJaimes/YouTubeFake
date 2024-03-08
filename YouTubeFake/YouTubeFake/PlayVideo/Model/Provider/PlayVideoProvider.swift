//
//  PlayVideoProvider.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 05/03/24.
//

import Foundation

protocol PlayVideoProviderProtocol{
    func getVideo(_ videoId : String) async throws ->  VideoModel
    func getRelatedVideos(_ relatedToVideoId : String) async throws -> VideoModel
    func getChannel(_ channelId : String) async throws -> ChannelModel
}

class PlayVideoProvider: PlayVideoProviderProtocol {
    func getVideo(_ videoId: String) async throws -> VideoModel {
        
        let queryItems = ["id" : videoId, "part": "snippet,contentDetails,status,statistics"]
        let request = RequestModel(endpoint: .videos, queryItems: queryItems)
        
        do{
            let model = try await ServiceLayer.callService(request, VideoModel.self)
            //debugPrint(model)
            return model
        }catch {
            throw error
        }
    }
    
    func getRelatedVideos(_ relatedToVideoId: String) async throws -> VideoModel {
        let queryItems = ["topicId" : relatedToVideoId, "part": "snippet", "maxResults": "50", "type":"video"]
        //let queryItems = ["relatedToVideoId" : relatedToVideoId, "part": "snippet", "maxResults": "50", "type":"video"]
        let request = RequestModel(endpoint: .search, queryItems: queryItems)
        
        do{
            let model = try await ServiceLayer.callService(request, VideoModel.self)
            return model
        }catch {
            throw error
        }
    }
    
    func getChannel(_ channelId : String) async throws -> ChannelModel{
        
        let queryItems : [String:String] = ["id" : channelId, "part": "snippet,statistics"]
        let request = RequestModel(endpoint: .channels, queryItems: queryItems)
        
        do{
            let model = try await ServiceLayer.callService(request, ChannelModel.self)
            return model
        }catch {
            throw error
        }
        
        
    }

}
