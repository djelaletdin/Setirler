//
//  HomeHorizontalController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 14.03.2021.
//

import UIKit

class TagsPoemsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let tagCellId = "tagsid"
    let poemCellId = "poemsid"
    
    var poemGroup: OrderRawData?
    var type: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TagsRowCell.self, forCellWithReuseIdentifier: tagCellId)
        collectionView.register(PoemsRowCell.self, forCellWithReuseIdentifier: poemCellId)
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return poemGroup?.data?.count ?? 0
        
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.type == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemCellId, for: indexPath) as! PoemsRowCell
            cell.titleLabel.text = String(indexPath.row)
            
            if let content = poemGroup?.data?[0].categoryContent{
                cell.titleLabel.text = content[0].name
            }

            return cell
        } else if self.type == 2{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagCellId, for: indexPath) as! TagsRowCell
            cell.titleLabel.text = "asdasd"
//            cell.layer.cornerRadius = 10
////            cell.layer.masksToBounds = true
            if let content = poemGroup?.data?[0].categoryContent{
                cell.titleLabel.text = content[0].name
            }

            return cell
        } else {
            
            // TODO: create an error message for user if enything goes wrong which will.
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagCellId, for: indexPath) as! TagsRowCell
            cell.titleLabel.text = "qq"
            
            if let content = poemGroup?.data?[0].categoryContent{
                cell.titleLabel.text = content[0].name
            }

            return cell
        }
        
    }
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 20
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2*topBottomPadding - lineSpacing)

        return .init(width: view.frame.width - 150, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: -10, left: 0, bottom: topBottomPadding, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    
}
