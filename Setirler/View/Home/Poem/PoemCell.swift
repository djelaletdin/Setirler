//
//  PoemCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/06/09.
//

import UIKit

class PoemCell: UICollectionViewCell {
     
    var poem: PoemData?
    {
        didSet{
            contentTextView.text = poem?.content

        }
    }
    
    let contentTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentTextView.allowsEditingTextAttributes = false
        contentTextView.font = UIFont(name: "SourceSansPro-Regular", size: 20) ?? .systemFont(ofSize: 20)
        contentTextView.isScrollEnabled = false
        
        
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                VerticalStackView(arrangedSubviews: [
                    contentTextView
                    ], spacing: 12)
                ], customSpacing: 20),
            ], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
