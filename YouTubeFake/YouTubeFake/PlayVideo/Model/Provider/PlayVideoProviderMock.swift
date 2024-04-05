//
//  PlayVideoProviderMock.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 05/03/24.
//

import Foundation

class PlayVideoProviderMock: PlayVideoProviderProtocol{
    var throwsError: Bool = false
    func getVideo(_ videoId : String) async throws -> VideoModel{
        if throwsError  {
            throw NetworkError.generic
        }
        guard let model = Utils.parseJson(jsonName: "VideoOnlyOne", model: VideoModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getRelatedVideos(_ relatedToVideoId : String) async throws -> VideoModel{
        if throwsError  {
            throw NetworkError.generic
        }
        guard let model = Utils.parseJson(jsonName: "SearchVideos", model: VideoModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
        
    }
    
    func getChannel(_ channelId : String) async throws -> ChannelModel{
        if throwsError  {
            throw NetworkError.generic
        }
        guard let model = Utils.parseJson(jsonName: "Channel", model: ChannelModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
}
