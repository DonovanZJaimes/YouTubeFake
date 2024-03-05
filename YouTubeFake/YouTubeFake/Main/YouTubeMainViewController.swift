//
//  YouTubeMainViewController.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 20/02/24.
//

import UIKit

class YouTubeMainViewController: BaseViewController {

    @IBOutlet var tabsView: TabsView!
    var rootPageViewController: RootPageViewController!
    private var options : [String] = ["HOME","VIDEOS","PLAYLIST","CHANNEL","ABOUT"]
    
    var currentPageIndex: Int = 0{
        willSet{
            //print("wilSet: \(currentPageIndex)")
            let cell = tabsView.collectionView.cellForItem(at: IndexPath(item: currentPageIndex, section: 0))
            cell?.isSelected = false
        }
        didSet{
            //print("didSet: \(currentPageIndex)")
            if let _ = rootPageViewController{
                rootPageViewController.currentPage = currentPageIndex
                let cell = tabsView.collectionView.cellForItem(at: IndexPath(item: currentPageIndex, section: 0))
                cell?.isSelected = true
            }
        }
    }
    
    var didTapOption : Bool = false{
        didSet{
            if didTapOption{
                tabsView.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now()+0.35) {
                    self.didTapOption.toggle()
                    self.tabsView.isUserInteractionEnabled = true
                }
            }
        }
    }
    var prevPercent : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        tabsView.buildView(delegate: self, options: options)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RootPageViewController {
            destination.delegateRoot = self
            rootPageViewController = destination
        }
    }
    
    override func dotsButtonPressed() {
        print("holi")
    }

}

extension YouTubeMainViewController: RootPageViewControllerDelegate {
    func scrollDetails(direction: ScrollDirecion, percent: CGFloat, index: Int) {
        if percent == 0.0 || didTapOption{
            return
        }
        
        let currentCell = tabsView.collectionView.cellForItem(at: IndexPath(item: index, section: 0))
        // ----->>>[view]
        if direction == .goingRight{
            if index == options.count-1 { return}
            
            //El next index sería el actual +1
            let nextCell = tabsView.collectionView.cellForItem(at: IndexPath(item: index+1, section: 0))
            
            //Se suma el acumulado, mas el % escroleado de la celda actual.
            let calculateNewLeading = currentCell!.frame.origin.x + (currentCell!.frame.width * percent)
            let newWidth = (prevPercent < percent) ? nextCell?.frame.width : currentCell?.frame.width
            
            //Se actualizan las variables con los constraints
            updateUnderlineConstraints(calculateNewLeading, newWidth!)
            
        }else{//left [view] <<<<------
            //Si está en la primera pagina, y trata de moverse hacea la derecha, retorna
            if index == 0 { return }
            
            //El next index sería el actual menos 1
            let nextCell = tabsView.collectionView.cellForItem(at: IndexPath(item: index-1, section: 0))
            
            //Se suma el acumulado, mas el % escroleado de la celda actual.
            let calculateNewLeading = currentCell!.frame.origin.x - (nextCell!.frame.width * percent)
            let newWidth = (prevPercent) < percent ? nextCell?.frame.width : currentCell?.frame.width
            
            //Se actualizan las variables con los constraints
            updateUnderlineConstraints(calculateNewLeading, newWidth!)
        }
        
        //Se guarda el valor previo para saber si va de derecha a izquerda dentro de la misma pagina.
        prevPercent = percent
    }
    
    func updateUnderlineConstraints(_ leading: CGFloat, _ width: CGFloat){
        tabsView.leadingConstraint?.constant = leading
        tabsView.widthConstraint?.constant = width
        tabsView.layoutIfNeeded()
    }
    
    func rootPageViewController(index: Int) {
        print(index)
        currentPageIndex = index
        tabsView.selectedItem = IndexPath(item: index, section: 0)
    }
}

extension YouTubeMainViewController: TabsViewDelegate {
    func didSelectOption(index: Int) {
        didTapOption = true
        var direction: UIPageViewController.NavigationDirection = .forward
        
        let currentCell = tabsView.collectionView.cellForItem(at: IndexPath(item: index, section: 0))!
        tabsView.updateUnderline(xOrigin: currentCell.frame.origin.x, width: currentCell.frame.width)
        
        if index < currentPageIndex {
            direction = .reverse
        }
        rootPageViewController.setViewControllersForIndex(index: index, direccion: direction)
        currentPageIndex = index
    }
    
    
}
