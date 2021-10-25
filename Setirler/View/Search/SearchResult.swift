//
//  SearchResult.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/05/29.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    

    let contentControlller = SearchResultController()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(contentControlller.view)
        
        contentControlller.view.fillSuperview(padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
