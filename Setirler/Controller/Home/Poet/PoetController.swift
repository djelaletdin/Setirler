//
//  PoetController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/17.
//

import UIKit

class PoetController: BaseController, UICollectionViewDelegateFlowLayout {

    fileprivate var poemId: Int
    
    fileprivate let poemListCellId = "poemListCellId"
    fileprivate let footerCellId = "footerCellId"
    fileprivate let headerCellId = "headercellid"
    fileprivate var page = 1
    fileprivate var isPaginating = false

    init(poemId: Int) {
    self.poemId = poemId
        super.init()
    }
    
    var poem: PoemData?{
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
        iv.constrainHeight(constant: 25)
        iv.constrainWidth(constant: 25)
        
        return iv
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.register(PoemListCell.self, forCellWithReuseIdentifier: poemListCellId)
        collectionView?.register(PoetHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)

        collectionView.register(LoadingFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId)

        setupNavBar()

    }
    
    
    

    
    func fetchData(){
        Service.shared.fetchPoems(id: self.poem?.poetID ?? 0, page: self.page, type: "poem" ) { rawData, error in
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
    
    //Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        
        case UICollectionView.elementKindSectionHeader:
            print("header is here")
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath) as! PoetHeaderCell
            headerView.poetNameLabel.text = self.poem?.poetName
            headerView.counterLabel.text = "\(self.poem?.poemCount ?? 0) eser"
            
            let url = URL(string: "http://poem.realapps.xyz/images/\(self.poem?.poetImage ?? "default.jpg")")
            headerView.imageView.kf.setImage(with: url)
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            print("footer is here")
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath)
            return footer
            
        default:
            fatalError("Unexpected element kind")
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
                Service.shared.fetchPoems(id: self.poem?.poetID ?? 0, page: self.page, type: "poem") { rawData, error in
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemListCellId, for: indexPath) as! PoemListCell
                if let content = poemGroup?.data[indexPath.row]{
                    cell.titleLabel.text = content.name
                    cell.sentenceLabel.text = "\(String(describing: (content.sentence)))"
                }
                return cell
            
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width-32, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

extension PoetController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

