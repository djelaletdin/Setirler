//
//  PoetDetailCell.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/20.
//

import UIKit
import Kingfisher

class PoetDetailCell: UICollectionViewCell {
    
    var poet: PoemData?{
        didSet{
            poetNameLabel.text = poet?.poetName
            counterLabel.text = "\(poet?.poemCount ?? 0) eser"
            let url = URL(string: "http://poem.realapps.xyz/images/\(poet?.poetImage ?? "asd")")
            imageView.kf.setImage(with: url)
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView(cornerRadius: 20)
        iv.constrainWidth(constant: 40)
        iv.constrainHeight(constant: 40)
        iv.layer.masksToBounds = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let poetNameLabel = UILabel(text: "Poet Name", font: UIFont(name: "SourceSansPro-Bold", size: 14)  ?? .systemFont(ofSize: 14))
    
    let counterLabel = UILabel(text: "Counter", font: UIFont(name: "SourceSansPro-Regular", size: 14)  ?? .systemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 9
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor

        self.layer.backgroundColor = UIColor(named: "ComponentColor")?.cgColor
        self.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        self.layer.shadowRadius = 9.0
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false
        
//        imageView.backgroundColor = .orange
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [poetNameLabel, counterLabel], spacing: 10), UIView()])
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.alignment = .center
        stackView.spacing = 16
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               // ColorUtils.loadCGColorFromAsset returns cgcolor for color name
            self.layer.backgroundColor = UIColor(named: "ComponentColor")?.cgColor
            self.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
            
           }
       }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


