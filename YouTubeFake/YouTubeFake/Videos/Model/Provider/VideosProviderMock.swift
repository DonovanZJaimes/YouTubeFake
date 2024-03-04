//
//  VideosProviderMock.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 01/03/24.
//

import Foundation

class VideosProviderMock: VideoProviderProtocol {
    func getVideos(channelId: String) async throws -> VideoModel {
        guard let model = Utils.parseJson(jsonName: "VideoList", model: VideoModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    
}
