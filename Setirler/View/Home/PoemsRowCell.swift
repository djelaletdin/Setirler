//
//  PoemsRowCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 15.04.2021.
//

import UIKit

class PoemsRowCell: UICollectionViewCell {
    
    
    let titleLabel = UILabel(text: "Title Name", font: .systemFont(ofSize: 20))
    let contentLabel = UILabel(text: "Content", font: .systemFont(ofSize: 10))
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
        
        

        let stackView = UIStackView(arrangedSubviews: [VerticalStackView(arrangedSubviews: [titleLabel, contentLabel, counterLabel], spacing: 4)])
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        addSubview(stackView)
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
