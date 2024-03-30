//
//  PlaylistProviderMock.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 30/03/24.
//

import Foundation
class PlaylistProviderMock: PlaylistProviderProtocol {
    func getPlaylists(channelId: String) async throws -> PlaylistModel {
        guard let model = Utils.parseJson(jsonName: "Playlists", model: PlaylistModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    
}
