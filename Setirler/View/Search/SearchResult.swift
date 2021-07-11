//
//  SearchResult.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/05/29.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    
    let titleLabel = UILabel(text: "Category Name", font: UIFont(name: "SourceSansPro-Bold", size: 18)  ?? .boldSystemFont(ofSize: 18))
    let contentControlller = CategoryController()

    override init(frame: CGRect) {
        super.init(frame: frame)
                
            addSubview(titleLabel)
            titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 16, bottom: 0, right: 16))
            
            addSubview(contentControlller.view)
            contentControlller.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
