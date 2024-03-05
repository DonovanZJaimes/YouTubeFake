//
//  TabsView.swift
//  YouTubeFake
//
//  Created by Donovan Z. Jaimes on 04/03/24.
//

import Foundation
import UIKit

protocol TabsViewDelegate: AnyObject {
    func didSelectOption(index: Int)
}

class TabsView: UIView {
    lazy var collectionView: UICollectionView = {
        //Create Collection
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        //Config Collection
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .backgroundColor
        
        //Register Cell
        collection.register(UINib(nibName: "\(OptionCellCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(OptionCellCollectionViewCell.self)")
        
        return collection
    }()
    
    var underLine: UIView = {
        var line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .whiteColor
        return line
    }()
    
    var selectedItem: IndexPath = IndexPath(item: 0, section: 0)
    var leadingConstraint : NSLayoutConstraint?
    var widthConstraint : NSLayoutConstraint?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configCollectionView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private var options = [String]()
    weak private var delegate: TabsViewDelegate?
    
    func buildView(delegate: TabsViewDelegate, options: [String]){
        self.delegate = delegate
        self.options = options
        collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.configUnderLine()
        }
    }
    
    private func configCollectionView(){
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func configUnderLine() {
        addSubview(underLine)
        NSLayoutConstraint.activate([
            underLine.heightAnchor.constraint(equalToConstant: 2.0),
            underLine.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        let currentCell = collectionView.cellForItem(at: selectedItem)!
        widthConstraint = underLine.widthAnchor.constraint(equalToConstant: currentCell.frame.width)
        widthConstraint?.isActive = true
        
        leadingConstraint = underLine.leadingAnchor.constraint(equalTo: currentCell.leadingAnchor)
        leadingConstraint?.isActive = true
    }
    
    func updateUnderline(xOrigin : CGFloat, width : CGFloat){
        widthConstraint?.constant = width
        leadingConstraint?.constant = xOrigin
        layoutIfNeeded()
    }
}

extension TabsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(OptionCellCollectionViewCell.self)", for: indexPath) as? OptionCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == 0{
            cell.highlightTitle(.whiteColor)
        }else{
            cell.isSelected = (selectedItem.item == indexPath.row)
        }
        let title = options[indexPath.row]
        cell.configCell(option: title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectOption(index: indexPath.item)
    }
   
}

extension TabsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = determineWidth(text: options[indexPath.item])
        return CGSize(width: width , height: frame.height)
    }
    
    func determineWidth(text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label.intrinsicContentSize.width + 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
