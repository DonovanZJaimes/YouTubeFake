//
//  RootPageViewController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import UIKit

//MARK: - Delegate of RootPageViewController
protocol RootPageViewControllerDelegate: AnyObject {
    //The index of the current controller of the PageView is sent
    func rootPageViewController(index: Int )
}

//MARK: - Class RootPageViewController
class RootPageViewController: UIPageViewController {
    /***views of the PageView */
    var subViewControllers = [UIViewController]()
    /***Current index of the diplayed controller*/
    var currentIndex: Int = 0
    weak var delegateRoot : RootPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        subViewControllers = [
            HomeViewController(),
            VideosViewController(),
            PlaylistViewController(),
            ChannelsViewController(),
            AboutViewController()
        ]
        /***Assign an index to each tag of each controller*/
        _ = subViewControllers.enumerated().map({$0.element.view.tag = $0.offset})
        
        setViewControllersForIndex(index: 0, direccion: .forward)
    }
    
    
    func setViewControllersForIndex (index: Int, direccion: NavigationDirection, animated: Bool = true) {
        setViewControllers([subViewControllers[index]], direction: direccion, animated: animated)
    }

   

}

//MARK: - Delegate and Data Source for PageView
extension RootPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        
        guard index > 0 else {return nil}
        return subViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        
        guard index < (subViewControllers.count - 1) else {return nil}
        return subViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let index = pageViewController.viewControllers?.first?.view.tag {
            currentIndex = index
            delegateRoot?.rootPageViewController(index: index)
        }
    }
    
}
