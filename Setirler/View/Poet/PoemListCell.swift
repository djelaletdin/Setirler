//
//  PoemListCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/20.
//

import UIKit

class PoemListCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Title Name", font: UIFont(name: "SourceSansPro-Bold", size: 14)  ?? .systemFont(ofSize: 14))
    let sentenceLabel = UILabel(text: "Counter", font: UIFont(name: "SourceSansPro-Regular", size: 14)  ?? .systemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 9
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor

        self.layer.backgroundColor = UIColor(named: "ComponentColor")?.cgColor
        self.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        self.layer.shadowRadius = 9.0
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false

//        imageView.backgroundColor = .orange
        let stackView = VerticalStackView(arrangedSubviews: [titleLabel, sentenceLabel], spacing: 5)
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.alignment = .leading
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               // ColorUtils.loadCGColorFromAsset returns cgcolor for color name
            self.layer.backgroundColor = UIColor(named: "ComponentColor")?.cgColor
            self.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
            
           }
       }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

