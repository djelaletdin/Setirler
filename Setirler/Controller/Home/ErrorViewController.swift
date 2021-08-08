//
//  ErrorViewController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/08/06.
//

import UIKit

class ErrorViewController: UIViewController {
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
        label.text = "“Men elmydama gözledim, \nGözlemegiň çägi ýok.”"
        return label
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 15)  ?? .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "FontColor")
        label.text = "Näsazlyk çykdy. Täzeden synanşyp görüň"
        return label
    }()
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        let stackView = VerticalStackView(arrangedSubviews: [imageView, poemSentenceLabel, warningLabel], spacing: 0)
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        view.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 120, left: 16, bottom: 120, right: 16))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}
