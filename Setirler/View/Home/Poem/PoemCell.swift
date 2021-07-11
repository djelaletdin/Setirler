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
            titleLabel.text = poem?.name
            poetNameLabel.text = poem?.poetName
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
        label.constrainHeight(constant: 28)
        label.textColor = #colorLiteral(red: 0.3294117647, green: 0.3137254902, blue: 0.3137254902, alpha: 1)
//        label.backgroundColor = .red
        label.text = "Title Name"
        label.font = UIFont(name: "SourceSerifPro-Bold", size: 26) ?? .systemFont(ofSize: 26)
        return label
    }()
    
    let poetNameLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .yellow
        label.textColor = #colorLiteral(red: 0.3294117647, green: 0.3137254902, blue: 0.3137254902, alpha: 1)
        label.constrainHeight(constant: 25)
        label.text = "Poet name"
        label.font = UIFont(name: "SourceSerifPro-SemiBold", size: 15) ?? .systemFont(ofSize: 15)
        return label
    }()
    
    let tagTextView: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "SourceSerifPro-Regular", size: 18) ?? .systemFont(ofSize: 18)
        text.isScrollEnabled = false
        text.isEditable = false
        text.textAlignment = .natural
        return text
    }()
    
    let tagsController = TagController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = VerticalStackView(arrangedSubviews: [titleLabel, poetNameLabel, contentTextView], spacing: 15)
        addSubview(stackView)
        stackView.alignment = .center
        stackView.fillSuperview(padding: .init(top: 20, left: 10, bottom: 20, right: 10))
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
