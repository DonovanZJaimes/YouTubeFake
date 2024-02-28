//
//  VideoTableViewCell.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 22/02/24.
//

import UIKit
import Kingfisher

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var dotsImage: UIImageView!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    var didTapDotsButton: (()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    
    private func configView() {
        selectionStyle = .none
        dotsImage.image = UIImage(named: "dots")?.withRenderingMode(.alwaysTemplate)
        dotsImage.tintColor = UIColor(named: "whiteColor")
    }
    
    func configCell(model: Any) {
        if let video = model as? ItemVideo {
            if let imageUrl = video.snippet?.thumbnails.medium?.url, let url = URL(string: imageUrl) {
                videoImage.kf.setImage(with: url)
            }
            videoName.text = video.snippet?.title ?? ""
            channelName.text = video.snippet?.channelTitle ?? ""
            
            viewsCountLabel.text = "\(video.statistics?.viewCount ?? "0") views · 3 months ago"
            
            
        } else if let playlistItems = model as? ItemPlaylistItems {
            if let imageUrl = playlistItems.snippet.thumbnails.medium?.url, let url = URL(string: imageUrl) {
                videoImage.kf.setImage(with: url)
            }
            videoName.text = playlistItems.snippet.title
            channelName.text = playlistItems.snippet.channelTitle
            
            viewsCountLabel.text = "332 views · 3 months ago"
        }
        
    }
    
    
    @IBAction func dotsButtonTapped(_ sender: UIButton) {
        if let tap = didTapDotsButton {
            tap()
        }
    }
}
