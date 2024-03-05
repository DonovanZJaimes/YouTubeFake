//
//  OptionCellCollectionViewCell.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 04/03/24.
//

import UIKit

class OptionCellCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var titleLabel: UILabel!
    override var isSelected: Bool{
        didSet{
            highlightTitle(isSelected ? .whiteColor : .grayColor)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func highlightTitle(_ color : UIColor){
        titleLabel.textColor = color
    }
    func configCell(option: String) {
        titleLabel.text = option
    }
}
