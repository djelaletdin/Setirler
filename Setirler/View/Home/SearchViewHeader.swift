//
//  SearchViewHeader.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 18.04.2021.
//

import UIKit

protocol SearchViewHeaderDelegate {

    // 2. create a function that will do something when the header is tapped
    func doSomething()
}

class SearchViewHeader: UICollectionReusableView {
    
    
    let backView = UIView()
//    weak var delegate: SearchViewHeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backView.layer.cornerRadius = 9
        backView.layer.borderWidth = 0
        backView.layer.borderColor = UIColor.lightGray.cgColor

//        backView.layer.backgroundColor = UIColor(named: "ComponentColor")?.resolvedColor(with: self.traitCollection).cgColor
        
//        
//        if #available(iOS 13.0, *) {
//            self.traitCollection.performAsCurrent {
//                backView.layer.backgroundColor = UIColor(named: "ComponentColor")?.cgColor
//            }
//        } else {
//            // Fallback on earlier versions
//        }
        
        backView.layer.backgroundColor = UIColor(named: "ComponentColor")?.cgColor
        
        
        backView.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        backView.layer.shadowOffset = CGSize(width: 2, height: 4)
        backView.layer.shadowRadius = 9.0
        backView.layer.shadowOpacity = 0.4
        backView.layer.masksToBounds = false
        
        addSubview(backView)
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
