//
//  UIImage+Extension.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 04/03/24.
//

import Foundation
import UIKit

extension UIImage {
    
    @nonobjc class var bellImage: UIImage {
        return (UIImage(named: "bell")?.withRenderingMode(.alwaysTemplate))!
    }
    
    @nonobjc class var dotsImage: UIImage {
        return (UIImage(named: "dots")?.withRenderingMode(.alwaysTemplate))!
    }
    
    @nonobjc class var magnifyingIcon: UIImage {
        return (UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate))!
    }
    
    @nonobjc class var castImage: UIImage {
        return (UIImage(named: "cast")?.withRenderingMode(.alwaysTemplate))!
    }
    
    @nonobjc class var magnifyingImage: UIImage {
        return (UIImage(named: "magnifying")?.withRenderingMode(.alwaysTemplate))!
    }
    
    /*@nonobjc class var videoPlaceholder: UIImage {
        guard let image = UIImage(named: "maxresdefault") else{
            fatalError("You should add the videoPlaceholder to the assets")
        }
        return image
    }*/
    @nonobjc class var videoPlaceholder: UIImage {
        return (UIImage(systemName: "photo.on.rectangle.fill"))!
    }
    
    @nonobjc class var personCircleFill: UIImage {
        return (UIImage(systemName: "person.circle.fill"))!
    }
    @nonobjc class var chevronDown: UIImage {
        return (UIImage(systemName: "chevron.down"))!
    }
    @nonobjc class var playFill: UIImage {
        return (UIImage(systemName: "play.fill"))!
    }
    @nonobjc class var pause: UIImage {
        return (UIImage(systemName: "pause"))!
    }
    /*
    @nonobjc class var chevronBackwardIcon: UIImage {
        return (UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysTemplate))!
    }
    
    @nonobjc class var micFillIcon: UIImage {
        return (UIImage(systemName: "mic.fill")?.withRenderingMode(.alwaysTemplate))!
    }
    
    @nonobjc class var xmarkIcon: UIImage {
        return (UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate))!
    }
    
    
    
    
    
    
    
    
    
    

    
    */
}
