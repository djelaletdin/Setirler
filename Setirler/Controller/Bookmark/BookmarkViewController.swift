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
    fileprivate var page = 1

    let realm = try! Realm()
    lazy var poems: Results<PoemRealmData> = { self.realm.objects(PoemRealmData.self) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PoemsRowCell.self, forCellWithReuseIdentifier: poemRowCell)
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
        
        let poem = poems[indexPath.row]
        
        let dummyPoem = PoemData(id: poem.id, poetID: 0, name: poem.name, content: poem.content, view: 0, poetName: poem.poetName, poetImage: "", poemCount: 0, tags: [])

        let destinationController  = PoemController(poemId: poems[indexPath.row].id)
            destinationController.poem = dummyPoem
            self.navigationController?.pushViewController(destinationController, animated: true)

    }

    
}

extension BookmarkViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poems.count
    }
    
   
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemRowCell, for: indexPath) as! PoemsRowCell
            cell.titleLabel.text = poems[indexPath.row].name
            cell.sentenceLabel.text = poems[indexPath.row].content
            cell.contentLabel.text = poems[indexPath.row].poetName
            return cell
        }
        

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.height - 2*topBottomPadding - 2*lineSpacing)
            return .init(width: view.frame.width-32, height:120)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }


}
