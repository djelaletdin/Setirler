//
//  TagViewController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/23.
//

import UIKit

class TagViewController: BaseController, UICollectionViewDelegateFlowLayout {

    fileprivate var tagId: Int

    init(tagId: Int) {
    self.tagId = tagId
        super.init()
    }
    
    var tagCellId = "TagGroupCell"

    var tag: Tag?{
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
        collectionView.register(TagGroupCell.self, forCellWithReuseIdentifier: tagCellId)
        
        setupNavBar()
        
        let number: CGFloat = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;

        print(number)

        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MainBackground")
        let safeArea: CGFloat = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        let alpha: CGFloat = 1 - ((scrollView.contentOffset.y + safeArea) / safeArea)
        
        navTitleLabel.alpha = -alpha
    }
    
    fileprivate func setupNavBar(){
        
        let stackView = UIStackView(arrangedSubviews: [navTitleLabel, UIView()], customSpacing: 10)
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        navTitleLabel.text = tag?.name
        stackView.constrainWidth(constant: view.frame.width)
        navigationItem.titleView = stackView

    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagCellId, for: indexPath) as! TagGroupCell
                cell.poetNameLabel.text = self.tag?.name
                cell.counterLabel.text = "\(self.tag?.poemCount ?? 0) eser"
                cell.descriptionLabel.text = self.tag?.tagDescription
                cell.poetDetailController.type = "tag"
                cell.poetDetailController.poetId = self.tag?.id
                cell.poetDetailController.didSelectHandler = { [weak self] poem in
                    let destinationController  = PoemController(poemId: poem.id)
                    destinationController.navigationController?.title = poem.name
                    destinationController.hidesBottomBarWhenPushed = true
                    self?.navigationController?.pushViewController(destinationController, animated: true)
                }
        
//            cell.poetDetailController.didSelectHandler = { [weak self] poem in
//                let destinationController  = PoemController(poemId: poem.id)
//                destinationController.navigationController?.title = poem.name
//                destinationController.hidesBottomBarWhenPushed = true
//                self?.navigationController?.pushViewController(destinationController, animated: true)
//            }

            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: CGFloat(self.tag?.poemCount ?? 0)*140+150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 0, bottom: 0, right: 0)
    }
    
}

extension TagViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

