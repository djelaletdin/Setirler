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
        label.textColor = #colorLiteral(red: 0.3294117647, green: 0.3137254902, blue: 0.3137254902, alpha: 1)
        label.constrainHeight(constant: 25)
        label.text = "Poet name"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 15) ?? .systemFont(ofSize: 15)
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(tagNameLabel)
        tagNameLabel.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
