//
//  CategoryGroupCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 03.04.2021.
//

import UIKit

class CategoryGroupCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Category Name", font: .boldSystemFont(ofSize: 30))
    let contentControlller = CategoryController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
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

