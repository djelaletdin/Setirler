//
//  TagCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/11.
//


import UIKit

class TagCell: UICollectionViewCell {
    
    let tagNameLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .yellow
        label.textColor = UIColor(named: "FontColor")
//        label.constrainHeight(constant: 25)
        label.text = "Poet name"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 15) ?? .systemFont(ofSize: 15)
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0
        self.layer.backgroundColor = UIColor(named: "TagColor")?.cgColor
        self.layer.masksToBounds = false

        addSubview(tagNameLabel)
        tagNameLabel.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
