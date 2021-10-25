//
//  TitleHeaderCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/10/25.
//

import UIKit

class TitleHeaderCell: UICollectionReusableView {
    

    let titleLabel = UILabel(text: "Title Name", font: UIFont(name: "SourceSansPro-Bold", size: 24)  ?? .systemFont(ofSize: 18))
    let counterLabel = UILabel(text: "Counter", font: UIFont(name: "SourceSansPro-SemiBold", size: 14)  ?? .systemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = UIStackView(arrangedSubviews: [VerticalStackView(arrangedSubviews: [titleLabel, counterLabel], spacing: 10), UIView()])

        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
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

