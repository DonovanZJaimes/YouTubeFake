//
//  PlaylistModel.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import Foundation


// AIzaSyDGiduVsaQlHSxbx3obdwf9JyjLP49p_MY
// MARK: - PlaylistModel
struct PlaylistModel: Decodable {
    let kind: String
    let etag: String
    let pageInfo: PageInfoPlaylist
    let items: [ItemsPlaylist]
}
