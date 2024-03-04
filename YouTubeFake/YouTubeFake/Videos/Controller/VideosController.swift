//
//  VideosController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 01/03/24.
//

import Foundation
protocol VideosViewProtocol: AnyObject {
    func getVideos(videoList: [ItemVideo])
}

class VideosController {
    
    private weak var delegate: VideosViewProtocol?
    private var provider: VideoProviderProtocol
    
    init(delegate: VideosViewProtocol, provider: VideoProviderProtocol = VideosProvider()) {
        self.delegate = delegate
        self.provider = provider
        #if DEBUG
        if MockManagerSingleton.shared.runAppWithMock {
            self.provider = VideosProviderMock()
        }
        #endif
    }
    
    @MainActor
    func getVideos()async {
        do {
            let videos = try await provider.getVideos(channelId: Constants.channelId).items
            delegate?.getVideos(videoList: videos)
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        
    }
    
    
}

