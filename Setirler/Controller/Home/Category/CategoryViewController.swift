//
//  CategoryViewController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/25.
//

import UIKit

class CategoryViewController: BaseController, UICollectionViewDelegateFlowLayout {

    fileprivate var cateogryId: Int

    init(cateogryId: Int) {
    self.cateogryId = cateogryId
        super.init()
    }
    
    var categoryCellListId = "categoryCellListId"

    var category: CategoryContent?{
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
        setupNavBar()
        super.viewDidLoad()
//        fetchData()
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.register(CategoryGroupListCell.self, forCellWithReuseIdentifier: categoryCellListId)
        

        
        let number: CGFloat = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;

        print(number)

        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeArea: CGFloat = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        let alpha: CGFloat = 1 - ((scrollView.contentOffset.y + safeArea) / safeArea)
        navTitleLabel.alpha = -alpha
        
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MainBackground")
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self;
    }
    
    fileprivate func setupNavBar(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButtonImageTapped(tapGestureRecognizer:)))
        backButtonImageView.isUserInteractionEnabled = true
        backButtonImageView.addGestureRecognizer(tapGestureRecognizer)
        let stackView = UIStackView(arrangedSubviews: [backButtonImageView, navTitleLabel, UIView()], customSpacing: 10)
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        navTitleLabel.text = category?.name
        stackView.constrainWidth(constant: view.frame.width)
        navigationItem.hidesBackButton = true
        navigationItem.titleView = stackView
    }
    
    @objc func backButtonImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.navigationController?.popViewController(animated: true)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    extension CategoryViewController{
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellListId, for: indexPath) as! CategoryGroupListCell
                cell.poetNameLabel.text = self.category?.name
                cell.counterLabel.text = "\(self.category?.poetCount ?? 0) şahyr"
                cell.categoryDetailController.categoryId = self.category?.id
                cell.categoryDetailController.didSelectHandler = { [weak self] poet in
                    
                    var dummyPoem = PoemData(id: 0, poetID: poet.id, name: "", content: "", view: 0, poetName: poet.name, poetImage: poet.photo, poemCount: poet.poemCount, tags: [])
                    
                    let destinationController  = PoetController(poemId: poet.id)
                    destinationController.navigationController?.title = poet.name
                    destinationController.poem = dummyPoem
                    self?.navigationController?.pushViewController(destinationController, animated: true)
                }

            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: CGFloat(self.category?.poetCount ?? 0)*140+150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 0, bottom: 0, right: 0)
    }
    
}

extension CategoryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

