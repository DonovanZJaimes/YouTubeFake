//
//  HomeController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 21/02/24.
//

import Foundation
protocol HomeControllerDelegate: AnyObject, BaseViewProtocol {
    func homeController (list: [[Any]], sectionTitleList: [String])
}

@MainActor class HomeController {
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
    
    func getHomeObjects() async {
        objectList.removeAll()
        sectionTitleList.removeAll()
        delegate?.loadingView(.show)
        async let channel = try await provider.getChannel(channelId: Constants.channelId).items
        async let playlist = try await provider.getPlaylists(channelId: Constants.channelId).items
        async let videos = try await provider.getVideos(searchString: "", channelId: Constants.channelId).items
    
        
        do {
            defer {
                delegate?.loadingView(.hide)
            }
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
            
        } catch  {
            delegate?.showError(error.localizedDescription, callback: {
                Task{[weak self] in
                    await self?.getHomeObjects()
                }
            })
        }
    }
    
    func getPlaylistItems(playlist: String) async -> PlaylistItemsModel? {
        do {
            let playlistItems = try await provider.getPlaylistItems(playlistId: playlist)
            return playlistItems
        } catch {
            delegate?.showError(error.localizedDescription, callback: {
                Task{[weak self] in
                    await self?.getHomeObjects()
                }
            })
            return nil
        }
    }
}
