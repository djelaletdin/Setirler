//
//  CategoryGroupCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 14.03.2021.
//

import UIKit

class TagsGroupCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Category Name", font: UIFont(name: "SourceSansPro-Bold", size: 22)  ?? .boldSystemFont(ofSize: 22))
    let contentControlller = TagsPoemsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentControlller.type = 2
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 3
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        
        addSubview(contentControlller.view)
        contentControlller.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

