//
//  HomeHorizontalController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 14.03.2021.
//

import UIKit

class HomeHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellid"
    var poemGroup: OrderRawData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CategoryRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .yellow
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        print(view.frame.height)

    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return poemGroup?.data?.count ?? 0
        
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryRowCell
        
        
//        cell.titleLabel.text = "adasdasd"
        
        if let content = poemGroup?.data?[0].categoryContent{
            cell.titleLabel.text = content[0].name
        }

        return cell
        
        
    }
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2*topBottomPadding - 2*lineSpacing)

        return .init(width: view.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
}
