//
//  InnerSearchController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/12.
//

import UIKit

class InnerSearchController: BaseController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "InnerSearchController"
    var searchResultSentences: [SearchDatum]?{
        didSet{
            collectionView.reloadData()
            collectionView.isScrollEnabled = false
        }
    }
    
    var didSelectHandler: ((SearchDatum)->())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let poem  = self.searchResultSentences?[indexPath.row]{
            print(poem.content)
            didSelectHandler?(poem)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.register(SearchResultsRowCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return searchResultSentences?.count ?? 0
        }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultsRowCell
        
        if let result = self.searchResultSentences?[indexPath.row]{
            let styledString = "<style>b{font-family: SourceSansPro-Bold;}</style><div style='font-family: SourceSansPro-Regular;'>\(result.content)</div>"
            cell.resultSentenceLabel.attributedText = styledString.htmlToAttributedString
            cell.resultSentenceLabel.textColor = UIColor(named: "FontColor")
//            cell.resultSentenceLabel.text = result.content
        }
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.height - 2*topBottomPadding - 2*lineSpacing)
        return .init(width: view.frame.width, height:20)
    }
}

