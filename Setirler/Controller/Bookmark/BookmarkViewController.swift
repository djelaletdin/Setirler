//
//  BookmarkViewController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/08/01.
//

import UIKit
import RealmSwift

class BookmarkViewController: BaseController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let poemRowCell = "categoryDetailCell"
    fileprivate let footerCellId = "footerCellId"
    fileprivate let emptyCellId = "emptyCellId"
    fileprivate let headerCellId = "headerCellId"
    fileprivate var page = 1
    
    private let sentences = ["“Men elmydama gözledim, \nGözlemegiň çägi ýok.”", "Men seni gözläp ýörşüme, \nKalby gussama dogratdym.",
                             "Adamlara has ynamly garadym \nÝeňiş bilen tamam boldy gözlegim.", "Sen haýsy suwlarda, tylla balygym? \nÝa bireýýäm tutup goýberdimmikäm?!",
                             "Ýitirenmi seň goýnuňda ýitirdim, \nTapanymam seň goýnuňda tapdym men.", "Bilemok ýüregňe barýan ýoly men, \nHem tapamok barýan ýoly tünegme.",
                            "Alnymyzdan Aý dogardy o günler, \nBagt açylyp, soňam birden bitipdir.", "Şygyr äleminde azaşyp ýörkäm \nEnem gelip, gapdalymda süýt goýsun.",
                             "Dur sen,\nSaklan, tizlik söýen Adamzat,\nGeçäýmäwer sen öz bagtyň deňinden.", "Başda goşgy, soň özümi söýerdim, \n...Indi o duýgular düşenok ýada.",
                            "Men Puşkini, Lermontowy okadym \nAk-garany saýgarmaýan döwrümde.", "Okyjym, men seniň taňry myhmanyň, \nMen senden ýaş. Saglyk-amanlyk sora",
                            "...Meňzäsim gelenok öňküligime, \nBu topraga bolsa, meňzäp bilemok.", "Öwret maňa öz diliňi, eý toprak, \nAç syryňy ol elýetmez sözleriň!?",
                            "Herhal, ýolda ýatan daş däl ekenim, \nArtyk däl ekenim ýeriň ýüzünde.", "Ýelpesin ýüzümi daňyň şemaly — \nŞoldur meniň üçin dünýäniň maly."]

    let realm = try! Realm()
    lazy var poems: Results<PoemRealmData> = { self.realm.objects(PoemRealmData.self) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PoemsRowCell.self, forCellWithReuseIdentifier: poemRowCell)
        collectionView.register(EmptySearchCell.self, forCellWithReuseIdentifier: emptyCellId)
        collectionView.register(TitleHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        poems = realm.objects(PoemRealmData.self)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        collectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
        
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if poems.count != 0{
            let poem = poems[indexPath.row]
            
            let dummyPoem = PoemData(id: poem.id, poetID: 0, name: poem.name, content: poem.content, view: 0, poetName: poem.poetName, poetImage: "", poemCount: 0, tags: [])

            let destinationController  = PoemController(poemId: poems[indexPath.row].id)
                destinationController.poem = dummyPoem
                self.navigationController?.pushViewController(destinationController, animated: true)
        }
        

    }

    
}

extension BookmarkViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if poems.count == 0{
            return 1
        } else{
            return poems.count
        }
    }
    
   
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if poems.count == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellId, for: indexPath) as! EmptySearchCell
                cell.poemSentenceLabel.text = sentences.randomElement()!
                cell.warningLabel.text = "Entek halanan eser ýok."
                return cell
            } else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemRowCell, for: indexPath) as! PoemsRowCell
                cell.titleLabel.text = poems[indexPath.row].name
                cell.sentenceLabel.text = poems[indexPath.row].content
                cell.contentLabel.text = poems[indexPath.row].poetName
                return cell
            }
        }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if poems.count == 0{
            return CGSize(width: 0, height: 0)
        } else{
            return CGSize(width: view.frame.width, height: 90)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath) as! TitleHeaderCell
                headerView.titleLabel.text = "Halanlarym"
            headerView.counterLabel.text = "\(self.poems.count) halanan eser"

                return headerView
            
            case UICollectionView.elementKindSectionFooter:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath)
                return footer
            default:
                assert(false, "Unexpected element kind")
           }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let guide = view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        
        if poems.count == 0{
            return CGSize(width: view.frame.width-32, height: height)
        } else{
            return CGSize(width: view.frame.width-32, height: 120)
        }


        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }


}
