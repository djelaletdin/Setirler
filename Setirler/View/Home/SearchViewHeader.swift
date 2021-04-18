//
//  SearchViewHeader.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 18.04.2021.
//

import UIKit

class SearchViewHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 9
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor

        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 6)
        self.layer.shadowRadius = 9.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
