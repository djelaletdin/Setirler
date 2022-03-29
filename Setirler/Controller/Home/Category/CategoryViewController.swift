//
//  CategoryViewController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/25.
//

import UIKit

class CategoryViewController: BaseController, UICollectionViewDelegateFlowLayout {

//    init(categoryId: Int) {
//    self.categoryId = categoryId
//        super.init()
//    }
    
    var titleString: String = ""
    
    
    fileprivate let categoryDetailCell = "categoryDetailCell"
    fileprivate let headerCellId = "headercellid"
    fileprivate let footerCellId = "footerCellId"
    fileprivate var page = 1
    fileprivate var isPaginating = false
    var categoryGroup: CategoryRawData?
        
    var categoryId: Int?{
        didSet{
            fetchData()
            print("ive recieved the id")
        }
    }
    
    let navTitleLabel: UILabel = {
        let label = UILabel()
//        label.text =  titleString
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        collectionView.register(PoetDetailCell.self, forCellWithReuseIdentifier: categoryDetailCell)
        collectionView?.register(TagHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        collectionView.register(LoadingFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId)
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        navTitleLabel.text = titleString
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
//        self.navigationController?.navigationBar.isTranslucent = false
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
//        navTitleLabel.text = categoryGroup?.data
        stackView.constrainWidth(constant: view.frame.width)
        navigationItem.hidesBackButton = true
        navigationItem.titleView = stackView
    }
    
    @objc func backButtonImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.navigationController?.popViewController(animated: true)
    }
    

    
    func fetchData(){
        Service.shared.fetchCategoryDetails(id: self.categoryId ?? 0, page: self.page) { categoryRawData, error in
            if let error = error{
                // TODO: - Show error to the user
                print("error while fetching category groups", error)
                return
            }
            if let data = categoryRawData{
                self.categoryGroup = data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.page+=1
            }
        }
    }
    
//    var didSelectHandler: ((CategoryData)->())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let poet  = self.categoryGroup?.data[indexPath.row]{
            
            let dummyPoem = PoemData(id: 0, poetID: poet.id, name: "", content: "", view: 0, poetName: poet.name, poetImage: poet.photo, poemCount: poet.poemCount, tags: [])
            
            let destinationController  = PoetController(poemId: poet.id)
            destinationController.navigationController?.title = poet.name
            destinationController.poem = dummyPoem
            self.navigationController?.pushViewController(destinationController, animated: true)
        }
    }

    
}

extension CategoryViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryGroup?.data.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        
        case UICollectionView.elementKindSectionHeader:
            print("header is here")
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath) as! TagHeaderCell
            headerView.poetNameLabel.text = titleString
            headerView.counterLabel.text = "\(self.categoryGroup?.total ?? 0) şahyr"
            headerView.descriptionLabel.isHidden = true
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            print("footer is here")
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath)
            return footer
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if let category = categoryGroup{
            if category.data.count >= category.total{
                print("i am small")
                return .init(width: view.frame.width, height: 0)
            } else{
                return .init(width: view.frame.width, height: 100)
            }
        } else{
            return .init(width: view.frame.width, height: 100)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let poem = categoryGroup{
            if indexPath.row == poem.data.count-1 && poem.data.count < poem.total && !isPaginating{
                self.isPaginating = true
                                
                Service.shared.fetchCategoryDetails(id: self.categoryId ?? 0, page: self.page) { categoryRawData, error in
                    if let error = error{
                        // TODO: - Show error to the user
                        print("eheheheheh")
                        print("error while fetching app groups", error)
                        return
                    }
                    
                    sleep(1)
                    if let data = categoryRawData{
                        self.categoryGroup?.data += data.data
                        DispatchQueue.main.async {

                            self.collectionView.reloadData()
        //                    self.indicator.stopAnimating()
        //                    self.indicator.hidesWhenStopped = true
        //                    self.collectionView.isHidden = false
                        }
                        self.page+=1
                        self.isPaginating = false
                    }
                }
                
            }
        }
        
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryDetailCell, for: indexPath) as! PoetDetailCell
                if let content = categoryGroup?.data[indexPath.row]{
                    
                    let dummyPoem = PoemData(id: 0, poetID: content.id, name: "", content: "", view: 0, poetName: content.name, poetImage: content.photo, poemCount: content.poemCount, tags: [])
                    
                    cell.poet = dummyPoem
                }
                return cell
           
        }
        

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.height - 2*topBottomPadding - 2*lineSpacing)
            return .init(width: view.frame.width-32, height:80)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

}

extension CategoryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
