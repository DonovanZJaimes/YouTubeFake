//
//  ChannelTableViewCell.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 22/02/24.
//

import UIKit
import Kingfisher


class ChannelTableViewCell: UITableViewCell {
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var channelInfoLabel: UILabel!
    @IBOutlet weak var subscriberNumbersLabel: UILabel!
    @IBOutlet weak var bellImage: UIImageView!
    @IBOutlet weak var subscribeLabel: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    func configView() {
        selectionStyle = .none
        bellImage.image = .bellImage
        bellImage.tintColor = .grayColor
        profileImage.layer.cornerRadius = 51 / 2
    }

    func configCell (model: ItemsChannel) {
        channelInfoLabel.text = model.snippet.description
        channelTitle.text = model.snippet.title
        subscriberNumbersLabel.text = "\(model.statistics?.subscriberCount ?? "0") subscribers · \(model.statistics?.videoCount ?? "0") videos"
        
        if let bannerUrl = model.brandingSettings?.image.bannerExternalUrl, let url = URL(string: bannerUrl) {
            bannerImage.kf.setImage(with: url)
        }
        
        let imageURl = model.snippet.thumbnails.medium.url
        guard let url = URL(string: imageURl) else {return}
        profileImage.kf.setImage(with: url)
        
    }
    
}
