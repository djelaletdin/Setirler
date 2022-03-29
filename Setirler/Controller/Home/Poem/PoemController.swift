//
//  PoemController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/06/09.
//

import UIKit
import RealmSwift

class PoemController: BaseController, UICollectionViewDelegateFlowLayout {

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
        iv.constrainHeight(constant: 25)
        iv.constrainWidth(constant: 25)
        return iv
    }()
    
    let heartImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "heart-empty")
        iv.constrainHeight(constant: 25)
        iv.constrainWidth(constant: 25)
//        let i = iv.image?.tinted(with: UIColor(named: "FontColor") ?? .green)
        return iv
    }()
    
    var indicator = UIActivityIndicatorView()

    func activityIndicatorSetup() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        indicator.isOpaque = false
        indicator.backgroundColor = UIColor(named: "MainBackground")
        indicator.center = .init(x: view.frame.width/2, y: view.frame.height/2-view.frame.height/10)
        indicator.style = .gray
        indicator.hidesWhenStopped = true
        indicator.color = UIColor(named: "FontColor")
        view.addSubview(indicator)
    }
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        activityIndicatorSetup()
        indicator.startAnimating()
        
        fetchData()

        collectionView.register(PoemCell.self, forCellWithReuseIdentifier: poemCellId)
        collectionView.register(PoemDetailCell.self, forCellWithReuseIdentifier: tagsCellId)
        collectionView.register(PoetDetailCell.self, forCellWithReuseIdentifier: poetDetailCellId)
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
        
//        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self;
    }
    
    @objc func backButtonImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addToFavorites(tapGestureRecognizer: UITapGestureRecognizer){
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
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
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
            let poem: Results<PoemRealmData> = { self.realm.objects(PoemRealmData.self).filter("id = \(self.poemId)")  }()
            try! realm.write {
                realm.delete(poem)
                heartImageView.image = UIImage(named: "heart-empty")
                setupNavBar()
                isAddedToFavorites = false
            }
    }
    
    
    
    fileprivate func fetchData(){
        let urlString = "http://poem.realapps.xyz/api/poem/\(poemId)"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (result: PoemRawData?, error) in
            if let poemData = result?.data{
                self.poem = poemData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.navTitleLabel.text = poemData.name
                    self.indicator.stopAnimating()
                }
            }
        }
    }

    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PoemController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemCellId, for: indexPath) as! PoemCell
            cell.poem = self.poem
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagsCellId, for: indexPath) as! PoemDetailCell
            cell.tagsController.tags = self.poem?.tags
            cell.tagsController.rootView = self
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poetDetailCellId, for: indexPath) as! PoetDetailCell
            cell.poet = self.poem
            return cell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 2{
            if let poetId = self.poem?.poetID{
                let destinationController  = PoetController(poemId: poetId)
                destinationController.poem = self.poem
                self.navigationController?.pushViewController(destinationController, animated: true)
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return .init(width: view.frame.width, height: view.frame.height-16)
        }else if indexPath.row == 1{
            return .init(width: view.frame.width-16-16, height: 70)
        } else{
            return .init(width: view.frame.width-16-16, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 40, right: 0)
    }
    
    
    
}

extension PoemController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
