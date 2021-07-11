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
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 250).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 220).isActive = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let poemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SourceSansPro-Bold", size: 18)  ?? .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
//        label.constrainHeight(constant: 80)
        label.textAlignment = .center
        label.backgroundColor = .blue
        label.text = "“Men elmydama gözledim, \nGözlemegiň çägi ýok.”"
        return label
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SourceSansPro-Bold", size: 18)  ?? .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
//        label.constrainHeight(constant: 80)
        label.textAlignment = .center
        label.backgroundColor = .blue
        label.text = "“Men elmydama gözledim, \nGözlemegiň çägi ýok.”"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

            print("i am searched")
            let stackView = VerticalStackView(arrangedSubviews: [imageView, poemLabel, warningLabel], spacing: 10)
            stackView.distribution = .equalSpacing
            stackView.alignment = .center
            addSubview(stackView)
            stackView.fillSuperview(padding: .init(top: 100, left: 10, bottom: 0, right: 10))
       

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
