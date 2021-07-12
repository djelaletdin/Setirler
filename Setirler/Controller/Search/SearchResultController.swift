//
//  SearchResultController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/12.
//

import UIKit

class SearchResultController: BaseController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "CategoryRowCell"
    var rootView: SearchViewController?

    var searchResultGroup: [SearchRawDatum]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("bashyrakda")
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultGroupCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.reloadData()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            
        return searchResultGroup?.count ?? 0
//        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultGroupCell
        print("wassap")
        if let content = searchResultGroup?[indexPath.row]{
            cell.titleLabel.text = content.categoryName
            cell.contentControlller.searchResultSentences = content.peomData
            
            cell.contentControlller.didSelectHandler = { [weak self] poem in
                let destinationController  = PoemController(poemId: poem.id )
                self?.rootView?.navigationController?.pushViewController(destinationController, animated: true)
            }
            
//            cell.contentControlller.
        }

        return cell
    }
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 20
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let content = searchResultGroup?[indexPath.row]{
            
            let height = content.peomData.count * 50
            
            return .init(width: Int(view.frame.width), height:height)
        } else{
            return .init(width: Int(view.frame.width), height:200)
        }
        
//        let height = (view.frame.height - 2*topBottomPadding - 2*lineSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
}

