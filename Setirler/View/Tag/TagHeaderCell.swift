//
//  TagGroupCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/23.
//

import UIKit

class TagHeaderCell: UICollectionReusableView {

    let poetNameLabel = UILabel(text: "Title Name", font: UIFont(name: "SourceSansPro-Bold", size: 24)  ?? .systemFont(ofSize: 18))
    let descriptionLabel = UILabel(text: "Title Name", font: UIFont(name: "SourceSansPro-Regular", size: 16)  ?? .systemFont(ofSize: 18))
    let counterLabel = UILabel(text: "Counter", font: UIFont(name: "SourceSansPro-SemiBold", size: 16)  ?? .systemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        descriptionLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [VerticalStackView(arrangedSubviews: [poetNameLabel, counterLabel, descriptionLabel], spacing: 10), UIView()])
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.alignment = .center
        stackView.spacing = 16
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
