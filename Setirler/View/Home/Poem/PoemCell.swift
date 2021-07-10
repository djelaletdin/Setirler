//
//  PoemCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/06/09.
//

import UIKit

class PoemCell: UICollectionViewCell {
    
    var padding = CGFloat()
    var poem: PoemData?
    {
        didSet{
            contentTextView.text = poem?.content
            poetNameLabel.text = poem?.poetName
        }
    }
    
    let contentTextView: UITextView = {
        let text = UITextView()
        text.allowsEditingTextAttributes = false
        text.font = UIFont(name: "SourceSansPro-Regular", size: 20) ?? .systemFont(ofSize: 20)
        text.isScrollEnabled = false
        text.isEditable = false
        text.textAlignment = .natural
        return text
    }()
    
    let poetNameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        label.font = UIFont(name: "SourceSansPro-Bold", size: 15) ?? .systemFont(ofSize: 15)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        contentTextView.backgroundColor = .yellow
        contentTextView.allowsEditingTextAttributes = false
        contentTextView.font = UIFont(name: "SourceSansPro-Regular", size: 20) ?? .systemFont(ofSize: 20)
        contentTextView.isScrollEnabled = false
        
        let stackView = VerticalStackView(arrangedSubviews: [contentTextView], spacing: 0)
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
