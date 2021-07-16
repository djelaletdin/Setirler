//
//  PoemDetailCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/11.
//

import UIKit

class PoemDetailCell: UICollectionViewCell {
    
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
//        label.constrainHeight(constant: 28)
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
//        label.constrainHeight(constant: 25)
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
        
        addSubview(tagsController.view)
        
        tagsController.view.fillSuperview(padding: .init(top: 0, left: 10, bottom: 20, right: 10))
        tagsController.view.constrainHeight(constant: 50)
//        
//        let stackView = UIStackView(arrangedSubviews: [poetNameLabel, UIView(), titleLabel])
//        
//        addSubview(stackView)
//        
//        stackView.anchor(top: tagsController.view.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 10, right: 10))
        
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
