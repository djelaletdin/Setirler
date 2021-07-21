//
//  PoemController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/06/09.
//

import UIKit

class PoemController: BaseController, UICollectionViewDelegateFlowLayout {

    fileprivate var poemId: Int

    init(poemId: Int) {
    self.poemId = poemId
        super.init()
    }
    
    fileprivate let poemCellId = "poemcellid"
    fileprivate let tagsCellId  = "tagscellid"
    fileprivate let poetDetailCellId = "poetDetailCellId"
    
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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.register(PoemCell.self, forCellWithReuseIdentifier: poemCellId)
        collectionView.register(PoemDetailCell.self, forCellWithReuseIdentifier: tagsCellId)
        collectionView.register(PoetDetailCell.self, forCellWithReuseIdentifier: poetDetailCellId)

        
        setupNavBar()
        
        let number: CGFloat = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        
        print(number)

        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeArea: CGFloat = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        let alpha: CGFloat = ((scrollView.contentOffset.y + safeArea) / safeArea)
        navTitleLabel.alpha = alpha
//        self.navigationController?.navigationBar.barTintColor = .yellow.withAlphaComponent(alpha)
    }
    
    fileprivate func setupNavBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MainBackground")
        let stackView = UIStackView(arrangedSubviews: [backButtonImageView, navTitleLabel, UIView()], customSpacing: 10)
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        navTitleLabel.text = poem?.name
        stackView.constrainWidth(constant: view.frame.width)
        navigationItem.hidesBackButton = true
        navigationItem.titleView = stackView
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self;
    }
    
    fileprivate func fetchData(){
        print(poemId)
        let urlString = "http://poem.djelaletdin.com/public/api/poem/\(poemId)"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (result: PoemRawData?, error) in
            if let poemData = result?.data{
                self.poem = poemData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.navTitleLabel.text = poemData.name
                }
            }
        }
    }
    
    @objc func poetNamePressed(sender:UITapGestureRecognizer) {
        let destinationController  = PoetController(poemId: 1)
        self.navigationController?.pushViewController(destinationController, animated: true)
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
            let tap = UITapGestureRecognizer(target: self, action: #selector(poetNamePressed))
            cell.poetNameLabel.isUserInteractionEnabled = true
            cell.poetNameLabel.addGestureRecognizer(tap)
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
            return .init(width: view.frame.width-16-16, height: view.frame.height-16)
        }else if indexPath.row == 1{
            return .init(width: view.frame.width-16-16, height: 70)
        } else{
            return .init(width: view.frame.width-16-16, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 40, right: 16)
    }
    
    
    
}

extension PoemController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
