//
//  RootPageViewController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import UIKit
enum ScrollDirecion {
    case goingLeft
    case goingRight
}

//MARK: - Delegate of RootPageViewController
protocol RootPageViewControllerDelegate: AnyObject {
    //The index of the current controller of the PageView is sent
    func rootPageViewController(index: Int )
    
    func scrollDetails(direction: ScrollDirecion, percent: CGFloat, index: Int)
}

//MARK: - Class RootPageViewController
class RootPageViewController: UIPageViewController {
    /***views of the PageView */
    var subViewControllers = [UIViewController]()
    /***Current index of the diplayed controller*/
    var currentIndex: Int = 0
    weak var delegateRoot : RootPageViewControllerDelegate?
    var startOffset : CGFloat = 0.0
    var currentPage : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        delegateRoot?.rootPageViewController(index: 0)
        setupViewControllers()
        setScrollViewDelegate()
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
    
    private func setScrollViewDelegate(){
        guard let scrollView = view.subviews.filter({$0 is UIScrollView}).first as? UIScrollView else {return}
        scrollView.delegate = self
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

extension RootPageViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.x
        print("startOffset: \(startOffset)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var direction = 0 //Scroll stopped
        if startOffset < scrollView.contentOffset.x{
            direction = 1 //right
        }else if startOffset > scrollView.contentOffset.x{
            direction = -1 //left
        }
        
        let positionFromStartOfCurrentPage = abs(startOffset - scrollView.contentOffset.x)
        let percent = positionFromStartOfCurrentPage /  self.view.frame.width
        delegateRoot?.scrollDetails(direction: (direction == 1) ? .goingRight : .goingLeft, percent: percent, index: currentPage)
        //print("percent: \(percent)")
        //print("direction: \(direction)")
    }
}
