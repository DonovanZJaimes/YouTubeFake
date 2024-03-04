//
//  HomeController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 21/02/24.
//

import Foundation
protocol HomeControllerDelegate: AnyObject {
    func homeController (list: [[Any]], sectionTitleList: [String])
}

class HomeController {
    var provider: HomeProviderProtocol
    weak var delegate: HomeControllerDelegate?
    private var objectList: [[Any]] = []
    private var sectionTitleList: [String] = []
    
    init(delegate: HomeControllerDelegate, provider: HomeProviderProtocol = HomeProvider()) {
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManagerSingleton.shared.runAppWithMock {
            self.provider = HomeProviderMock()
        }
        #endif
        
    }
    @MainActor
    func getHomeObjects() async{
        objectList.removeAll()
        sectionTitleList.removeAll()
        async let channel = try await provider.getChannel(channelId: Constants.channelId).items
        async let playlist = try await provider.getPlaylists(channelId: Constants.channelId).items
        async let videos = try await provider.getVideos(searchString: "", channelId: Constants.channelId).items
    /*func getHomeObjects () async {
        objectList.removeAll()
        async let channel = try await provider.getChanel(chaneelId: Constants.channelId).items
        async let playlist = try await provider.getPlaylists(chaneelId: Constants.channelId).items
        async let videos = try await provider.getVideos(searchString: "", chaneelId: Constants.channelId).items
        */
        
        do {
            let (responseChannel, responsePlaylist, responseVideos) = await (try channel, try playlist, try videos)
            //Index 0
            objectList.append(responseChannel)
            sectionTitleList.append("")
            
            if let playlistId = responsePlaylist.first?.id, let responsePlaylistItems = await getPlaylistItems(playlist: playlistId) {
                //Index 1
                objectList.append(responsePlaylistItems.items )
                sectionTitleList.append(responsePlaylist.first?.snippet.title ?? "")
            }
            //Index 2 y 3
            objectList.append(responseVideos)
            sectionTitleList.append("Uploads")
            objectList.append(responsePlaylist)
            sectionTitleList.append("Created playlist")
            
            delegate?.homeController(list: objectList, sectionTitleList: sectionTitleList)
            
        } catch {
            print(error)
        }
    }
    
    func getPlaylistItems(playlist: String) async -> PlaylistItemsModel? {
        do {
            let playlistItems = try await provider.getPlaylistItems(playlistId: playlist)
            return playlistItems
        } catch {
            print("error:", error)
            return nil
        }
    }
}
