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
        navTitleLabel.text = tag?.name
        stackView.constrainWidth(constant: view.frame.width)
        navigationItem.hidesBackButton = true
        navigationItem.titleView = stackView
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self;
        
//        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
        
    }
    
    
//    fileprivate func fetchData(){
//        print(poemId)
//        let urlString = "http://poem.djelaletdin.com/public/api/poem/\(poemId)"
//        Service.shared.fetchGenericJSONData(urlString: urlString) { (result: PoemRawData?, error) in
//            if let poemData = result?.data{
//                self.poem = poemData
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                    self.navTitleLabel.text = poemData.name
//                }
//            }
//        }
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }

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

