//
//  HomeViewController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    lazy var controller = HomeController(delegate: self)
    private var objectList: [[Any]] = []
    private var sectionTitleList: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()

        Task {
            await controller.getHomeObjects()
        }
    }
    func configTableView() {
        //Cells
        let nibChanel = UINib(nibName: "\(ChannelTableViewCell.self)", bundle: nil)
        tableView.register(nibChanel, forCellReuseIdentifier: "\(ChannelTableViewCell.self)")
        
        let nibVideo = UINib(nibName: "\(VideoTableViewCell.self)", bundle: nil)
        tableView.register(nibVideo, forCellReuseIdentifier: "\(VideoTableViewCell.self)")
        
        let nibPlaylist = UINib(nibName: "\(PlaylistTableViewCell.self)", bundle: nil)
        tableView.register(nibPlaylist, forCellReuseIdentifier: "\(PlaylistTableViewCell.self)")
        
        //title
        tableView.register(SectionTitleView.self, forHeaderFooterViewReuseIdentifier: "\(SectionTitleView.self)")
        
        //Delegate and Data Source
        tableView.dataSource = self
        tableView.delegate = self
        
        //Others
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: -15, left: 0, bottom: -80, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        if velocity < -5 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else if velocity > 5 {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }



}

extension HomeViewController: HomeControllerDelegate {
    func homeController(list: [[Any]], sectionTitleList: [String]) {
        objectList = list
        self.sectionTitleList = sectionTitleList
        tableView.reloadData()
    }
    
    
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = objectList[indexPath.section]
        switch model {
        case  let items where ((items as? [ItemsChannel]) != nil) :
            let channelCell = tableView.dequeueReusableCell(withIdentifier: "\(ChannelTableViewCell.self)", for: indexPath) as! ChannelTableViewCell
            channelCell.configCell(model: items[indexPath.row] as! ItemsChannel)
            return channelCell
        case  let items where ((items as? [ItemPlaylistItems]) != nil) :
            let playlistItemCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoTableViewCell.self)", for: indexPath) as! VideoTableViewCell
            playlistItemCell.didTapDotsButton = {[weak self] in
                self?.configButtonSheet()
            }
            playlistItemCell.configCell(model: items[indexPath.row] as! ItemPlaylistItems)
            return playlistItemCell
        case  let items where ((items as? [ItemVideo]) != nil) :
            let videoCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoTableViewCell.self)", for: indexPath) as! VideoTableViewCell
            videoCell.didTapDotsButton = { [weak self] in
                self?.configButtonSheet()
            }
            videoCell.configCell(model: items[indexPath.row] as! ItemVideo)
            return videoCell
        case  let items where ((items as? [ItemsPlaylist]) != nil) :
            let playlistCell = tableView.dequeueReusableCell(withIdentifier: "\(PlaylistTableViewCell.self)", for: indexPath) as! PlaylistTableViewCell
            playlistCell.didTapDotsButton = {[weak self] in
                self?.configButtonSheet()
            }
            playlistCell.configCell(model: items[indexPath.row] as! ItemsPlaylist)
            return playlistCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 :
            return UITableView.automaticDimension
        case 1, 2:
            return 95
        case 3:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(SectionTitleView.self)") as? SectionTitleView else{
            return nil
        }
        sectionView.title.text = sectionTitleList[section]
        sectionView.configView()
        return sectionView
    }
    
    func configButtonSheet() {
        let vc = BottomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
}
