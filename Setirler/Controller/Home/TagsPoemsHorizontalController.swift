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
    
    var poemGroup: Datum?
    var type: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TagsRowCell.self, forCellWithReuseIdentifier: tagCellId)
        collectionView.register(PoemsRowCell.self, forCellWithReuseIdentifier: poemCellId)
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poemGroup?.categoryContent?.count ?? 0
        
//        return 6
    }
    
    var didSelectHandler: ((CategoryContent)->())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let poem  = self.poemGroup?.categoryContent?[indexPath.row]{
            print(poem.name ?? "shygyr")
            didSelectHandler?(poem)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.type == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemCellId, for: indexPath) as! PoemsRowCell
            cell.titleLabel.text = String(indexPath.row)
            
            if let content = poemGroup?.categoryContent?[indexPath.row]{
                cell.titleLabel.text = (content.name)
                cell.contentLabel.text = content.poet
            }

            return cell
        } else if self.type == 2{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagCellId, for: indexPath) as! TagsRowCell
            cell.titleLabel.text = "asdasd"
            if let content = poemGroup?.categoryContent?[indexPath.row]{
                cell.titleLabel.text = content.name
                cell.contentLabel.text = content.categoryContentDescription
                cell.counterLabel.text = "\(content.poemCount ?? 0) eser"
            }

            return cell
        } else {
            
            // TODO: create an error message for user if anything goes wrong which will.
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagCellId, for: indexPath) as! TagsRowCell
            cell.titleLabel.text = "qq"
            
            if let content = poemGroup{
                cell.titleLabel.text = content.categoryName
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
