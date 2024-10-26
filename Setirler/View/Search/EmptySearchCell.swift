//
//  EmptySearchCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/12.
//

import UIKit

class EmptySearchCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "reading")
        iv.widthAnchor.constraint(equalToConstant: 250).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 220).isActive = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let poemSentenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SourceSansPro-Bold", size: 18)  ?? .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "FontColor")
        return label
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 15)  ?? .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "FontColor")
        label.text = "Gözlege gabat gelýän eser tapylmady"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = VerticalStackView(arrangedSubviews: [UIView(), VerticalStackView(arrangedSubviews: [poemSentenceLabel, warningLabel], spacing: 30), UIView()])
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
