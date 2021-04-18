//
//  CategoryGroupRowCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 03.04.2021.
//

import UIKit

class CategoryRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 9)
    let titleLabel = UILabel(text: "Title Name", font: .systemFont(ofSize: 20))
    
    let counterLabel = UILabel(text: "Counter", font: .systemFont(ofSize: 10))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        self.layer.cornerRadius = 9
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor

        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        self.layer.shadowRadius = 9.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
        
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        imageView.backgroundColor = .orange
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [titleLabel, counterLabel], spacing: 20)])
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.alignment = .center
        stackView.spacing = 16
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

