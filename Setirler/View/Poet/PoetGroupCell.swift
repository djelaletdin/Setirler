//
//  PoetGroupCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/20.
//

import UIKit

class PoetGroupCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 9)
    let poetNameLabel = UILabel(text: "Title Name", font: UIFont(name: "SourceSansPro-Bold", size: 14)  ?? .systemFont(ofSize: 14))
    let counterLabel = UILabel(text: "Counter", font: UIFont(name: "SourceSansPro-Regular", size: 14)  ?? .systemFont(ofSize: 14))
    
    let poetDetailController = PoetDetailController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
        imageView.constrainWidth(constant: 40)
        imageView.constrainHeight(constant: 40)
        imageView.backgroundColor = .orange
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [poetNameLabel, counterLabel], spacing: 10), UIView()])
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 5, bottom: 100, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.alignment = .center
        stackView.spacing = 16
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        addSubview(poetDetailController.view)
        poetDetailController.view.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

