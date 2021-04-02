//
//  CategoryRowCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 01.04.2021.
//

import UIKit

class CategoryRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 9)
    let titleLabel = UILabel(text: "Title Name", font: .systemFont(ofSize: 20))
    let contentLabel = UILabel(text: "Content", font: .systemFont(ofSize: 10))
    let counterLabel = UILabel(text: "Counter", font: .systemFont(ofSize: 10))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        
        imageView.constrainWidth(constant: 48)
        imageView.constrainHeight(constant: 64)
        imageView.backgroundColor = .orange
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [titleLabel, contentLabel, counterLabel], spacing: 4)])
        addSubview(stackView)
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


