//
//  UILabel+Extension.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 06/03/24.
//

import Foundation
import UIKit

extension UILabel {
    func highlight(searchedText: String, color: UIColor = .red) {
        guard let txtLabel = self.text else { return }
        let attributeTxt = NSMutableAttributedString(string: txtLabel)
        
        searchedText.forEach {_ in
            let range: NSRange = attributeTxt.mutableString.range(of: searchedText, options: .caseInsensitive)
            attributeTxt.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            attributeTxt.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: self.font.pointSize), range: range)
        }
        attributedText = attributeTxt
    }
}
