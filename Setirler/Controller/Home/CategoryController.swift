//
//  CategoryController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 03.04.2021.
//

import UIKit

class CategoryController: BaseController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "CategoryRowCell"
    var poemGroup: Datum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CategoryRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            
        return poemGroup?.categoryContent?.count ?? 0
        
//        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryRowCell
        
        
//        cell.titleLabel.text = String(indexPath.row)
        
        if let content = poemGroup{
            cell.titleLabel.text = content.categoryContent?[indexPath.row].name
            cell.counterLabel.text = "\(content.categoryContent?[indexPath.row].poet) şahyr"
        }

        return cell
        
        
    }
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 20
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.height - 2*topBottomPadding - 2*lineSpacing)
        return .init(width: view.frame.width - 30, height:100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
}
