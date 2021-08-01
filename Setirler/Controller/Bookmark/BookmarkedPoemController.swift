//
//  File.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/08/01.
//

import UIKit
import RealmSwift

class BookmarkedPoemController: BaseController, UICollectionViewDelegateFlowLayout {

    fileprivate var poemId: Int

    init(poemId: Int) {
    self.poemId = poemId
        super.init()
    }
    
    fileprivate let poemCellId = "poemcellid"
    fileprivate let tagsCellId  = "tagscellid"
    fileprivate let poetDetailCellId = "poetDetailCellId"
    
    fileprivate var isAddedToFavorites = false
    
    var poem: PoemData?
    
    let navTitleLabel: UILabel = {
        let label = UILabel()
        label.text =  "Goşgy ady"
        label.alpha = 0
        label.textColor = UIColor(named: "FontColor")
        label.font = UIFont(name: "SourceSansPro-Bold", size: 18) ?? .systemFont(ofSize: 18)
        return label
    }()
    
    let backButtonImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "back")
//        iv.constrainHeight(constant: 23)
//        iv.constrainWidth(constant: 23)
        return iv
    }()
    
    let heartImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "heart-empty")
        return iv
    }()

    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(named: "MainBackground")

        collectionView.register(PoemCell.self, forCellWithReuseIdentifier: poemCellId)
        setupNavBar()
                
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeArea: CGFloat = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        let alpha: CGFloat = 1 - ((scrollView.contentOffset.y + safeArea) / safeArea)
        navTitleLabel.alpha = -alpha
    }
    
    fileprivate func setupNavBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MainBackground")
        let backButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButtonImageTapped(tapGestureRecognizer:)))
        backButtonImageView.isUserInteractionEnabled = true
        backButtonImageView.addGestureRecognizer(backButtonTapGestureRecognizer)
        
        let categories: Results<PoemRealmData> = { self.realm.objects(PoemRealmData.self).filter("id = \(self.poemId)")  }()
        var heartTapGestureRecognizer = UITapGestureRecognizer()

        
        if categories.count > 0 {
            isAddedToFavorites = true
        } else{
            isAddedToFavorites = false
        }
        
        if isAddedToFavorites{
            heartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteFromFavorites(tapGestureRecognizer:)))
            heartImageView.image = UIImage(named: "heart-filled")
        } else{
            heartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addToFavorites(tapGestureRecognizer:)))
            heartImageView.image = UIImage(named: "heart-empty")
        }
        heartImageView.isUserInteractionEnabled = true
        heartImageView.addGestureRecognizer(heartTapGestureRecognizer)
        
        let stackView = UIStackView(arrangedSubviews: [backButtonImageView, navTitleLabel, UIView(), heartImageView], customSpacing: 10)
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 30)
        stackView.isLayoutMarginsRelativeArrangement = true
        navTitleLabel.text = poem?.name
        stackView.constrainWidth(constant: view.frame.width)
        navigationItem.hidesBackButton = true
        navigationItem.titleView = stackView
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self;
    }
    
    @objc func backButtonImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addToFavorites(tapGestureRecognizer: UITapGestureRecognizer){
        
        if let poem = self.poem{
            let poemRealm = PoemRealmData()
            poemRealm.id = poem.id
            poemRealm.name = poem.name
            poemRealm.content = poem.content
            poemRealm.poetName = poem.poetName
            try! realm.write({
                realm.add(poemRealm)
            })
            heartImageView.image = UIImage(named: "heart-filled")
            setupNavBar()
            isAddedToFavorites = true
            
        }
        
    }
    
    @objc func deleteFromFavorites(tapGestureRecognizer: UITapGestureRecognizer){
        
            let poem: Results<PoemRealmData> = { self.realm.objects(PoemRealmData.self).filter("id = \(self.poemId)")  }()
            try! realm.write {
                realm.delete(poem)
                heartImageView.image = UIImage(named: "heart-empty")
                setupNavBar()
                isAddedToFavorites = false
            }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookmarkedPoemController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemCellId, for: indexPath) as! PoemCell
            cell.poem = self.poem
            return cell

        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return .init(width: view.frame.width-16-16, height: view.frame.height-16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 40, right: 16)
    }
    
    
    
}

extension BookmarkedPoemController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}



