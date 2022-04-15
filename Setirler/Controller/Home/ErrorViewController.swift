//
//  ErrorViewController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/08/06.
//

import UIKit

class ErrorViewController: UIViewController {

    private let sentences = ["“Men elmydama gözledim, \nGözlemegiň çägi ýok.”", "Men seni gözläp ýörşüme, \nKalby gussama dogratdym.",
                             "Adamlara has ynamly garadym \nÝeňiş bilen tamam boldy gözlegim.", "Sen haýsy suwlarda, tylla balygym? \nÝa bireýýäm tutup goýberdimmikäm?!",
                             "Ýitirenmi seň goýnuňda ýitirdim, \nTapanymam seň goýnuňda tapdym men.", "Bilemok ýüregňe barýan ýoly men, \nHem tapamok barýan ýoly tünegme.",
                            "Alnymyzdan Aý dogardy o günler, \nBagt açylyp, soňam birden bitipdir.", "Şygyr äleminde azaşyp ýörkäm \nEnem gelip, gapdalymda süýt goýsun.",
                             "Dur sen,\nSaklan, tizlik söýen Adamzat,\nGeçäýmäwer sen öz bagtyň deňinden.", "Başda goşgy, soň özümi söýerdim, \n...Indi o duýgular düşenok ýada.",
                            "Men Puşkini, Lermontowy okadym \nAk-garany saýgarmaýan döwrümde.", "Okyjym, men seniň taňry myhmanyň, \nMen senden ýaş. Saglyk-amanlyk sora",
                            "...Meňzäsim gelenok öňküligime, \nBu topraga bolsa, meňzäp bilemok.", "Öwret maňa öz diliňi, eý toprak, \nAç syryňy ol elýetmez sözleriň!?",
                            "Herhal, ýolda ýatan daş däl ekenim, \nArtyk däl ekenim ýeriň ýüzünde.", "Ýelpesin ýüzümi daňyň şemaly — \nŞoldur meniň üçin dünýäniň maly."]
    
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
        label.text = "Bir näsazlyk ýüze çykdy. Täzeden synanşyň."
        return label
    }()
    
    
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        poemSentenceLabel.text = sentences.randomElement()
        let stackView = VerticalStackView(arrangedSubviews: [UIView(), VerticalStackView(arrangedSubviews: [poemSentenceLabel, warningLabel], spacing: 30), UIView()])
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        
        view.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}
