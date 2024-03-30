//
//  PlaylistController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 30/03/24.
//

import Foundation
protocol PlaylistControllerProtocol: AnyObject, BaseViewProtocol {
    func getPlaylist(Playlist: [ItemsPlaylist])
}

class PlaylistController {
    
    private var provider: PlaylistProviderProtocol
    private weak var delegate: PlaylistControllerProtocol?
    
    init(provider: PlaylistProviderProtocol = PlaylistProvider(), delegate: PlaylistControllerProtocol) {
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManagerSingleton.shared.runAppWithMock {
            self.provider = PlaylistProviderMock()
        }
        #endif
        
    }
    
    
    @MainActor
    func getPlaylist() async {
        delegate?.loadingView(.show)
        do {
            defer {
                delegate?.loadingView(.hide)
            }
            let playlist = try await provider.getPlaylists(channelId: Constants.channelId)
            delegate?.getPlaylist(Playlist: playlist.items)
            
        }catch {
            delegate?.showError(error.localizedDescription, callback: {
                Task{[weak self] in
                    await self?.getPlaylist()
                }
            })
            debugPrint(error.localizedDescription)
        }
        
    }
    
    
    
}
