//
//  PlaylistViewController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import UIKit

class PlaylistViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var controller = PlaylistController(delegate: self)
    var itemsPlaylist = [ItemsPlaylist]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        Task {
            await controller.getPlaylist()
        }
    }
    
    func configTableView () {
        tableView.dataSource = self
        tableView.delegate = self
        let nibPlaylist = UINib(nibName: "\(PlaylistTableViewCell.self)", bundle: nil)
        tableView.register(nibPlaylist, forCellReuseIdentifier: "\(PlaylistTableViewCell.self)")
    }


   

}

extension PlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsPlaylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PlaylistTableViewCell.self)", for: indexPath) as! PlaylistTableViewCell
        let item = itemsPlaylist[indexPath.row]
        
        cell.didTapDotsButton = { [weak self] in
            self?.configButtonSheet()
        }
        
        cell.configCell(model: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func configButtonSheet() {
        let vc = BottomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
}

extension PlaylistViewController: PlaylistControllerProtocol {
    func getPlaylist(Playlist: [ItemsPlaylist]) {
        itemsPlaylist = Playlist
        tableView.reloadData()
    }
    
    
}
