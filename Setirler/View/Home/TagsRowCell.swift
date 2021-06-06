//
//  CategoryRowCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 01.04.2021.
//

import UIKit

class TagsRowCell: UICollectionViewCell {
    
    
    let titleLabel = UILabel(text: "Title Name", font: UIFont(name: "SourceSansPro-Bold", size: 14) ?? .systemFont(ofSize: 14))
    let contentLabel = UILabel(text: "Content", font: UIFont(name: "SourceSansPro-Regular", size: 14) ?? .systemFont(ofSize: 14))
    let counterLabel = UILabel(text: "Counter", font: UIFont(name: "SourceSansPro-Regular", size: 14) ?? .systemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        
        self.layer.cornerRadius = 9
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor

        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowRadius = 9.0
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false

        let stackView = UIStackView(arrangedSubviews: [VerticalStackView(arrangedSubviews: [titleLabel, contentLabel, UIView(), counterLabel], spacing: 4)])
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        addSubview(stackView)
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


