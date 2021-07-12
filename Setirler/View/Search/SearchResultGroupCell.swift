//
//  SearchResultGroupCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/12.
//

import UIKit

class SearchResultGroupCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Category Name", font: UIFont(name: "SourceSansPro-Bold", size: 16)  ?? .boldSystemFont(ofSize: 16))
    let contentControlller = InnerSearchController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        addSubview(contentControlller.view)
        contentControlller.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
