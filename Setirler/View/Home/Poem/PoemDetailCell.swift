//
//  PoemDetailCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/11.
//

import UIKit

class PoemDetailCell: UICollectionViewCell {
    
    var padding = CGFloat()


    let tagsController = TagController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tagsController.view)
        
        tagsController.view.fillSuperview(padding: .init(top: 0, left: 0, bottom: 20, right: 0))
//        tagsController.view.constrainHeight(constant: 50)
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
