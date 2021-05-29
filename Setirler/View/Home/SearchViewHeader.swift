//
//  SearchViewHeader.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 18.04.2021.
//

import UIKit

class SearchViewHeader: UICollectionReusableView {
    
    
    let backView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backView.layer.cornerRadius = 9
        backView.layer.borderWidth = 0
        backView.layer.borderColor = UIColor.lightGray.cgColor

        backView.layer.backgroundColor = UIColor.white.cgColor
        backView.layer.shadowColor = UIColor.lightGray.cgColor
        backView.layer.shadowOffset = CGSize(width: 2, height: 4)
        backView.layer.shadowRadius = 9.0
        backView.layer.shadowOpacity = 0.4
        backView.layer.masksToBounds = false
        
        addSubview(backView)
        backView.fillSuperview(padding:UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) )
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
