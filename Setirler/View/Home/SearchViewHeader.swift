//
//  SearchViewHeader.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 18.04.2021.
//

import UIKit

protocol SearchViewHeaderDelegate {

    func doSomething()
}

class SearchViewHeader: UICollectionReusableView {
    
    
    let backView = UIView()
    
    let searchLabel: UILabel = {
       let label = UILabel()
        label.text  = "Gözleg"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 14)
        label.textColor = UIColor(named: "FontColor")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backView.layer.cornerRadius = 9
        backView.layer.borderWidth = 0
        backView.layer.borderColor = UIColor.lightGray.cgColor
        backView.layer.backgroundColor = UIColor(named: "ComponentColor")?.cgColor
        backView.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        backView.layer.shadowOffset = CGSize(width: 2, height: 4)
        backView.layer.shadowRadius = 9.0
        backView.layer.shadowOpacity = 0.4
        backView.layer.masksToBounds = false
        
        addSubview(backView)
        backView.addSubview(searchLabel)
        searchLabel.fillSuperview(padding:UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) )
        backView.fillSuperview(padding:UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) )
        
        
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               // ColorUtils.loadCGColorFromAsset returns cgcolor for color name
            backView.layer.backgroundColor = UIColor(named: "ComponentColor")?.cgColor
            backView.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
            
           }
       }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
