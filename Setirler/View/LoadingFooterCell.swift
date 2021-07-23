//
//  LoadingFooterCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/22.
//

import UIKit

class LoadingFooterCell: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let aiv = UIActivityIndicatorView(style: .white)
        aiv.color = .darkGray
        aiv.startAnimating()
        

        addSubview(aiv)
        aiv.centerInSuperview(size: .init(width: 200, height: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
