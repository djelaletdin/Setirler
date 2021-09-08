//
//  PoetController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/17.
//

import UIKit

class PoetController: BaseController, UICollectionViewDelegateFlowLayout {

    fileprivate var poemId: Int

    init(poemId: Int) {
    self.poemId = poemId
        super.init()
    }
    
    var poetCellId = "poetCellId"

    var poem: PoemData?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    let navTitleLabel: UILabel = {
        let label = UILabel()
        label.text =  "shahyr ady"
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
//        fetchData()
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.register(PoetGroupCell.self, forCellWithReuseIdentifier: poetCellId)
        setupNavBar()
        
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
           flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
         }
  
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeArea: CGFloat = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        let alpha: CGFloat = 1 - ((scrollView.contentOffset.y + safeArea) / safeArea)
        navTitleLabel.alpha = -alpha
//        self.navigationController?.navigationBar.barTintColor = .yellow.withAlphaComponent(alpha)
    }
    
    fileprivate func setupNavBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MainBackground")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButtonImageTapped(tapGestureRecognizer:)))
        backButtonImageView.isUserInteractionEnabled = true
        backButtonImageView.addGestureRecognizer(tapGestureRecognizer)
        
        let stackView = UIStackView(arrangedSubviews: [backButtonImageView, navTitleLabel, UIView()], customSpacing: 10)
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        navTitleLabel.text = poem?.poetName
        stackView.constrainWidth(constant: view.frame.width)
        
        navigationItem.hidesBackButton = true
        navigationItem.titleView = stackView
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    @objc func backButtonImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PoetController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poetCellId, for: indexPath) as! PoetGroupCell
            cell.poetNameLabel.text = self.poem?.poetName
            cell.counterLabel.text = "\(self.poem?.poemCount ?? 0) eser"
            cell.poetDetailController.poetId = self.poem?.poetID
        
            cell.poetDetailController.didSelectHandler = { [weak self] poem in
                let destinationController  = PoemController(poemId: poem.id)
                destinationController.navigationController?.title = poem.name
                self?.navigationController?.pushViewController(destinationController, animated: true)
            }
        
            let url = URL(string: "http://poem.djelaletdin.com/public/images/\(self.poem?.poetImage ?? "default.jpg")")
            cell.imageView.kf.setImage(with: url)
//            cell.imageView.makeRounded()
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = CGFloat((self.poem?.poemCount ?? 0)*120)+150
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}

extension PoetController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

