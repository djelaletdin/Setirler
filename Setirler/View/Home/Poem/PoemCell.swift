//
//  PoemCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/06/09.
//

import UIKit

class PoemCell: UICollectionViewCell {
     
    var poem: PoemData?{
        didSet{
            nameLabel.text = poem?.name
            contentTextField.text = poem?.content
            
        }
    }
    
    let nameLabel = UILabel(text: "Poem Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let contentTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let stackView = VerticalStackView(arrangedSubviews: [
//            UIStackView(arrangedSubviews: [
//                VerticalStackView(arrangedSubviews: [
//                    nameLabel,
//                    UIStackView(arrangedSubviews: [ UIView()]),
//                    contentTextField
//                    ], spacing: 12)
//                ], customSpacing: 20),
//            ], spacing: 16)
//        addSubview(stackView)
//        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        
        addSubview(nameLabel)
        nameLabel.fillSuperview()
        backgroundColor = .red
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
