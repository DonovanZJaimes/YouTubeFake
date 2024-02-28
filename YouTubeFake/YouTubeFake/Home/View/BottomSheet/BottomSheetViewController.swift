//
//  BottomSheetViewController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 26/02/24.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var optionContainer: UIView!
    @IBOutlet weak var overlayView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        optionContainer.animateBottomSheet(show: true) {}
    }
    
    func createGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOverlay(_:)))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapOverlay (_ sender: UITapGestureRecognizer) {
        optionContainer.animateBottomSheet(show: false) {
            self.dismiss(animated: false)
        }
        
    }


}
