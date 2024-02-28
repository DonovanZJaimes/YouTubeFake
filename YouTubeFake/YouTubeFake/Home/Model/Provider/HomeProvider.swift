//
//  HomeProvider.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 21/02/24.
//

import Foundation
/*protocol HomeProviderProtocol {
    func getVideos(searchString: String, chaneelId: String) async throws -> VideoModel
    func getChanel(chaneelId: String) async throws -> ChannelModel
    func getPlaylists(chaneelId: String) async throws -> PlaylistModel
    func getPlaylistItems(playlistId: String) async throws -> PlaylistItemsModel
}

class HomeProvider: HomeProviderProtocol {
    func getVideos(searchString: String, chaneelId: String) async throws -> VideoModel {
        var queryParams: [String:String] = ["part":"snippet", "type": "video"]
        if !searchString.isEmpty {
            queryParams["q"] = searchString
        }
        if !chaneelId.isEmpty {
            queryParams["channelId"] = chaneelId
        }
        
        let requestModel = RequestModel(endpoint: .videos, queryItems: queryParams)
        
        do {
            let videos = try await ServiceLayer.callService(requestModel, VideoModel.self)
            return videos
        } catch {
            print(error)
            throw error
        }
    }
    
    func getChanel(chaneelId: String) async throws -> ChannelModel {
        let queryParams: [String:String] = ["part": "snippet,statistics,brandingSettings" ,
                                            "id": chaneelId ]
        
        let requestModel = RequestModel(endpoint: .channels, queryItems: queryParams)
        
        do {
            let chanel = try await ServiceLayer.callService(requestModel, ChannelModel.self)
            return chanel
        } catch {
            print(error)
            throw error
        }
    }
    
    
    func getPlaylists(chaneelId: String) async throws -> PlaylistModel {
        let queryParams: [String:String] = ["part": "snippet,contentDetails" ,
                                            "channelId": chaneelId ]
        
        let requestModel = RequestModel(endpoint: .playlist, queryItems: queryParams)
        
        do {
            let playlist = try await ServiceLayer.callService(requestModel, PlaylistModel.self)
            return playlist
        } catch {
            print(error)
            throw error
        }
    }
    func getPlaylistItems(playlistId: String) async throws -> PlaylistItemsModel {
        let queryParams: [String:String] = ["part":"snippet,id,contentDetails",
                                            "playlistId":playlistId]
        
        let requestModel = RequestModel(endpoint: .playlistItems, queryItems: queryParams)
        
        do {
            let playlistItems = try await ServiceLayer.callService(requestModel, PlaylistItemsModel.self)
            return playlistItems
        } catch {
            print(error)
            throw error
        }
    }

}

*/
protocol HomeProviderProtocol{
    func getVideos(searchString : String, channelId : String) async throws -> VideoModel
    func getChannel(channelId : String) async throws -> ChannelModel
    func getPlaylists(channelId : String) async throws -> PlaylistModel
    func getPlaylistItems(playlistId : String) async throws -> PlaylistItemsModel
}


class HomeProvider : HomeProviderProtocol{
    func getVideos(searchString : String, channelId : String) async throws -> VideoModel{
        var queryParams : [String:String] = ["part":"snippet", "type": "video"]
        if !channelId.isEmpty{
            queryParams["channelId"] = channelId
        }
        if !searchString.isEmpty{
            queryParams["q"] = searchString
        }
        let requestModel = RequestModel(endpoint: .search, queryItems: queryParams)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, VideoModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
    }
    
    func getChannel(channelId : String) async throws -> ChannelModel{
        let queryParams : [String:String] = ["part":"snippet,statistics,brandingSettings",
                                             "id":channelId]

        let requestModel = RequestModel(endpoint: .channels, queryItems: queryParams)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, ChannelModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
    }
    
    func getPlaylists(channelId : String) async throws -> PlaylistModel{
        let queryParams : [String:String] = ["part":"snippet,contentDetails",
                                             "channelId":channelId]

        let requestModel = RequestModel(endpoint: .playlist, queryItems: queryParams)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, PlaylistModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
    }
    
    func getPlaylistItems(playlistId : String) async throws -> PlaylistItemsModel{
        let queryParams : [String:String] = ["part":"snippet,id,contentDetails",
                                             "playlistId":playlistId]

        let requestModel = RequestModel(endpoint: .playlistItems, queryItems: queryParams)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, PlaylistItemsModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
    }
    
    
}
