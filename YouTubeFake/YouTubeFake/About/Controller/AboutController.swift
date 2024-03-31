//
//  AboutController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 30/03/24.
//

import Foundation
protocol AboutControllerProtocol: AnyObject {
    func getInfo(_ info: String)
}

class AboutController {
    private weak var delegate: AboutControllerProtocol?
    
    init(delegate: AboutControllerProtocol) {
        self.delegate = delegate
    }
    
    func configController() {
        NotificationCenter.default.addObserver(self, selector: #selector(getInfo(notification:)), name: .aboutInfo, object: nil)
    }
    
    @objc func getInfo(notification: Notification) {
        guard let value = notification.object as? String else {return}
        delegate?.getInfo(value)
    }
    
    
}
