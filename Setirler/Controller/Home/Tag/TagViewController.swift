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
    
    fileprivate let poemRowCellId = "poemRowCellId"
    fileprivate let footerCellId = "footerCellId"
    fileprivate let headerCellId = "headercellid"
    fileprivate var page = 1
    fileprivate var isPaginating = false

    var tag: Tag?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    var poemGroup: PoemListRawData?
    
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
        return iv
    }()
        
    override func viewDidLoad() {
        setupNavBar()
        super.viewDidLoad()
        fetchData()
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.register(PoemsRowCell.self, forCellWithReuseIdentifier: poemRowCellId)
        collectionView?.register(TagHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)

        collectionView.register(LoadingFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeArea: CGFloat = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        let alpha: CGFloat = 1 - ((scrollView.contentOffset.y + safeArea) / safeArea)
        navTitleLabel.alpha = -alpha
        
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MainBackground")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self;
    }
    
    func fetchData(){
        Service.shared.fetchPoems(id: self.tag?.id ?? 0, page: self.page, type: "tag" ) { rawData, error in
            if let error = error{
                // TODO: - Show error to the user
                print("error while fetching app groups", error)
                return
            }
            if let data = rawData{
                self.poemGroup = data
                DispatchQueue.main.async {

                    self.collectionView.reloadData()
                }
                self.page+=1
            }
        }
    }
    
    fileprivate func setupNavBar(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButtonImageTapped(tapGestureRecognizer:)))
        backButtonImageView.isUserInteractionEnabled = true
        backButtonImageView.addGestureRecognizer(tapGestureRecognizer)
        let stackView = UIStackView(arrangedSubviews: [backButtonImageView, navTitleLabel, UIView()], customSpacing: 10)
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        navTitleLabel.text = tag?.name
        stackView.constrainWidth(constant: view.frame.width)
        self.navigationController?.navigationBar.isTranslucent = false
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

extension TagViewController{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        
        case UICollectionView.elementKindSectionHeader:
            print("header is here")
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath) as! TagHeaderCell
            headerView.poetNameLabel.text = self.tag?.name
            headerView.counterLabel.text = "\(self.tag?.poemCount ?? 0) eser"
            headerView.descriptionLabel.text = self.tag?.tagDescription
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            print("footer is here")
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath)
            return footer
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.poemGroup?.data.count ?? 0
    }
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath)
//        return footer
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if let poem = poemGroup{
            if poem.data.count >= poem.total{
                print("i am small")
                return .init(width: view.frame.width, height: 0)
            } else{
                return .init(width: view.frame.width, height: 100)
            }
        } else{
            return .init(width: view.frame.width, height: 100)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("pressed")
        if let poem  = self.poemGroup?.data[indexPath.row]{
            let destinationController  = PoemController(poemId: poem.id)
            destinationController.navigationController?.title = poem.name
            self.navigationController?.pushViewController(destinationController, animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let poem = poemGroup{
            if indexPath.row == poem.data.count-1 && poem.data.count < poem.total && !isPaginating{
                self.isPaginating = true
                Service.shared.fetchPoems(id: self.tag?.id ?? 0, page: self.page, type: "tag") { rawData, error in
                    if let error = error{
                        // TODO: - Show error to the user
                        print("error while fetching app groups", error)
                        return
                    }
                    sleep(1)
                    if let data = rawData{
                        self.poemGroup?.data += data.data
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        self.page+=1
                        self.isPaginating = false
                    }
                }
            }
        }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemRowCellId, for: indexPath) as! PoemsRowCell
                if let content = poemGroup?.data[indexPath.row]{
                    cell.titleLabel.text = content.name
                    cell.contentLabel.text = content.poetName
                    cell.sentenceLabel.text = "\(String(describing: (content.sentence)))"
                }
                return cell
            
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width-32, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

extension TagViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

