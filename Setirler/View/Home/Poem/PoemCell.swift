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
            contentTextView.textColor = UIColor(named: "FontColor")
            contentTextView.backgroundColor = UIColor(named: "MainBackground")
            contentTextView.text = poem?.content
            titleLabel.text = poem?.name
            tagsController.tags = poem?.tags
        }
    }
    

    
    let contentTextView: UITextView = {
        let text = UITextView()
//        text.backgroundColor = .green
        text.textColor = #colorLiteral(red: 0.3294117647, green: 0.3137254902, blue: 0.3137254902, alpha: 1)
        text.font = UIFont(name: "SourceSerifPro-Regular", size: 18) ?? .systemFont(ofSize: 18)
        text.isScrollEnabled = false
        text.isEditable = false
        text.textAlignment = .natural
        return text
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.constrainHeight(constant: 30)
        label.textColor = UIColor(named: "FontColor")
//        label.backgroundColor = .red
        label.text = "Title Name"
        label.font = UIFont(name: "SourceSansPro-Bold", size: 24) ?? .systemFont(ofSize: 24)
        return label
    }()

    
    let tagTextView: UITextView = {
        let f = UITextView()
        f.font = UIFont(name: "SourceSerifPro-Regular", size: 18) ?? .systemFont(ofSize: 18)
        f.backgroundColor = UIColor(named: "MainBackground")
        f.textColor = UIColor(named: "FontColor")
        f.isScrollEnabled = false
        f.isEditable = false
        f.textAlignment = .natural
        return f
    }()
    
    let tagsController = TagController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let stackView = VerticalStackView(arrangedSubviews: [titleLabel, contentTextView], spacing: 15)
        addSubview(stackView)
        stackView.alignment = .center
        stackView.fillSuperview(padding: .init(top: 0, left: 10, bottom: 20, right: 10))
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
