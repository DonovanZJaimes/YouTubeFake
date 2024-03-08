//
//  HomeViewController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import UIKit
import FloatingPanel

class HomeViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    
    lazy var controller = HomeController(delegate: self)
    private var objectList: [[Any]] = []
    private var sectionTitleList: [String] = []
    var fpc: FloatingPanelController?
    var floatingPanelIsPresented: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configFloatingPanel()
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = objectList[indexPath.section]
        var videoId: String = ""
        switch item {
        case  let items where ((items as? [ItemPlaylistItems]) != nil) :
            let item = items[indexPath.row] as! ItemPlaylistItems
            videoId = item.contentDetails?.videoId ?? ""
            //print("playlst")
        case  let items where ((items as? [ItemVideo]) != nil) :
            let item = items[indexPath.row] as! ItemVideo
            videoId = item.id ?? ""
            //print("video")
        default :
            return
        }
        
        
        if floatingPanelIsPresented{
            fpc?.willMove(toParent: nil)
            fpc?.hide(animated: true, completion: {[weak self] in
                guard let self = self else {return}
                // Remove the floating panel view from your controller's view.
                self.fpc?.view.removeFromSuperview()
                // Remove the floating panel controller from the controller hierarchy.
                self.fpc?.removeFromParent()
                
                self.dismiss(animated: true, completion: {
                    self.presentViewPanel(videoId)
                })
            })
            return
        }
        presentViewPanel(videoId)
        
        
        
        
    }
    
    
}

extension HomeViewController: FloatingPanelControllerDelegate {
    func presentViewPanel(_ id: String) {
        let contentVC = PlayVideoViewController()
        contentVC.videoId = id
        
        contentVC.goingToBeCollapsed = {[weak self] goingToBeCollapsed in
            guard let self = self else {return}
            if goingToBeCollapsed{
                self.fpc?.move(to: .tip, animated: true)
                NotificationCenter.default.post(name: .viewPosition, object: ["position":"bottom"])
                self.fpc?.surfaceView.contentPadding = .init(top: 0, left: 0, bottom: 0, right: 0)
            }else{
                self.fpc?.move(to: .full, animated: true)
                NotificationCenter.default.post(name: .viewPosition, object: ["position":"top"])
                self.fpc?.surfaceView.contentPadding = .init(top: -48, left: 0, bottom: -48, right: 0)
            }
        }
        
        contentVC.isClosedVideo = {[weak self]  in
            self?.floatingPanelIsPresented = false
            
        }
        
        fpc?.set(contentViewController: contentVC)
        fpc?.track(scrollView: contentVC.tableView)
        guard let fpc = fpc else { return }
        floatingPanelIsPresented = true
        present(fpc, animated: true)
    }
    func configFloatingPanel() {
        fpc = FloatingPanelController(delegate: self)
        fpc?.isRemovalInteractionEnabled = true
        fpc?.surfaceView.grabberHandle.isHidden = true
        fpc?.layout = MyFloatingPanelLayout()
        fpc?.surfaceView.contentPadding = .init(top: -48, left: 0, bottom: -48, right: 0)
    }
    
    func floatingPanelDidRemove(_ fpc: FloatingPanelController) {
        floatingPanelIsPresented = false
    }
    func floatingPanelWillEndDragging(_ fpc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
        if targetState.pointee != .full {
            NotificationCenter.default.post(name: .viewPosition, object: ["position":"bottom"])
            fpc.surfaceView.contentPadding = .init(top: 0, left: 0, bottom: 0, right: 0)
        } else{
            NotificationCenter.default.post(name: .viewPosition, object: ["position":"top"])
            fpc.surfaceView.contentPadding = .init(top: -48, left: 0, bottom: -48, right: 0)
        }
    }
    
    
}

extension NSNotification.Name{
    static let viewPosition = Notification.Name("viewPosition")
    static let expand = Notification.Name("expand")
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .full
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 0.0, edge: .top, referenceGuide: .safeArea),
        //.half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 60.0, edge: .bottom, referenceGuide: .safeArea),
    ]
}

