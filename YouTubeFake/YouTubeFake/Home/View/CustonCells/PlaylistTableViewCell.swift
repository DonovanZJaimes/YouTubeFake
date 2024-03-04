//
//  PlaylistTableViewCell.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 22/02/24.
//

import UIKit
import Kingfisher

class PlaylistTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dotsImage: UIImageView!
    @IBOutlet weak var videoCountOverlay: UILabel!
    @IBOutlet weak var videoCount: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    var didTapDotsButton: (()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView(){
        selectionStyle = .none
        super.awakeFromNib()
        dotsImage.image = .dotsImage
        dotsImage.tintColor = .whiteColor
    }
    
    func configCell(model : ItemsPlaylist){
        videoTitle.text = model.snippet.title
        videoCount.text = String(model.contentDetails.itemCount)+" videos"
        videoCountOverlay.text = String(model.contentDetails.itemCount)
        
        let imageUrl = model.snippet.thumbnails.medium.url
        if let url = URL(string: imageUrl){
            videoImage.kf.setImage(with: url)
        }
    }
    
    @IBAction func dotsButtonTapped(_ sender: UIButton) {
        if let tap = didTapDotsButton {
            tap()
        }
        
    }
    
}
