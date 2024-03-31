//
//  AboutViewController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import UIKit

class AboutViewController: UIViewController {
    

    @IBOutlet weak var infoTextView: UITextView!
    lazy var delegate = AboutController(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.configController()

        
    }


   

}

extension AboutViewController: AboutControllerProtocol {
    func getInfo(_ info: String) {
        infoTextView.text = info
    }
    
    
}
