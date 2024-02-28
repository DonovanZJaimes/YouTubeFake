//
//  YouTubeMainViewController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import UIKit

class YouTubeMainViewController: UIViewController {

    var rootPageViewController: RootPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RootPageViewController {
            destination.delegateRoot = self
            rootPageViewController = destination
        }
    }

}

extension YouTubeMainViewController: RootPageViewControllerDelegate {
    func rootPageViewController(index: Int) {
        print(index)
    }
    
    
}
