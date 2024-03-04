//
//  VideosViewController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import UIKit

class VideosViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    lazy var controller = VideosController(delegate: self)
    private var videoList: [ItemVideo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        Task {
            await controller.getVideos()
        }
        
    }


    func configTableView() {
        //Cells
        //let nibVideo = UINib(nibName: "\(VideoTableViewCell.self)", bundle: nil)
        //tableView.register(nibVideo, forCellReuseIdentifier: "\(VideoTableViewCell.self)")
        tableView.register(cell: VideoTableViewCell.self)
        
        
        //title
        tableView.register(SectionTitleView.self, forHeaderFooterViewReuseIdentifier: "\(SectionTitleView.self)")
        
        //Delegate and Data Source
        tableView.dataSource = self
        tableView.delegate = self
        
        //Others
        tableView.separatorColor = .clear
    }

}
extension VideosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: VideoTableViewCell.self, for: indexPath)
        /*guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(VideoTableViewCell.self)", for: indexPath) as? VideoTableViewCell else {
            return UITableViewCell()
        }*/
        let video = videoList[indexPath.row]
        cell.didTapDotsButton = { [weak self] in
            self?.configButtonSheet()
        }
        cell.configCell(model: video)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func configButtonSheet() {
        let vc = BottomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
}

extension VideosViewController: VideosViewProtocol {
    func getVideos(videoList: [ItemVideo]) {
        self.videoList = videoList
        tableView.reloadData()
    }
    
    
}

