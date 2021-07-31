//
//  SearchResultsRowCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/12.
//

import UIKit

class SearchResultsRowCell: UICollectionViewCell {
    
    
    let resultSentenceLabel = UILabel(text: "Title Name", font: UIFont(name: "SourceSansPro-Bold", size: 15) ?? .systemFont(ofSize: 14))

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "MainBackground")
        addSubview(resultSentenceLabel)
        resultSentenceLabel.fillSuperview(padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


