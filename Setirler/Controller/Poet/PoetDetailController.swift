//
//  PoetDetailController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/20.
//

import UIKit

class PoetDetailController: BaseController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let poemListCellId = "poemListCellId"
    fileprivate let poemTagListCellId = "poemTagListCellId"
    fileprivate let footerCellId = "footerCellId"
    fileprivate var page = 1
    fileprivate var isPaginating = false
    var poemGroup: PoemListRawData?
    
    var type: String?
    
    var poetId: Int?{
        didSet{
            fetchData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PoemListCell.self, forCellWithReuseIdentifier: poemListCellId)
        collectionView.register(PoemsRowCell.self, forCellWithReuseIdentifier: poemTagListCellId)
        collectionView.register(LoadingFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId)
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.isScrollEnabled = false
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    

    
    func fetchData(){
        print(self.poetId ?? 0)
        
        Service.shared.fetchPoems(id: self.poetId ?? 0, page: self.page, type: self.type ?? "poet") { rawData, error in
            if let error = error{
                // TODO: - Show error to the user
                print("error while fetching app groups", error)
                return
            }
            if let data = rawData{
                self.poemGroup = data
                DispatchQueue.main.async {

                    self.collectionView.reloadData()
//                    self.indicator.stopAnimating()
//                    self.indicator.hidesWhenStopped = true
//                    self.collectionView.isHidden = false
                }
                self.page+=1
            }
        }
    }
    
    var didSelectHandler: ((PoemListContent)->())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let poem  = self.poemGroup?.data[indexPath.row]{
            didSelectHandler?(poem)
        }
    }

    
}

extension PoetDetailController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poemGroup?.data.count ?? 0
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath)
        return footer
    }
    
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let poem = poemGroup{
            if indexPath.row == poem.data.count-1 && poem.data.count < poem.total && !isPaginating{
                self.isPaginating = true
                Service.shared.fetchPoems(id: self.poetId ?? 0, page: self.page, type: self.type ?? "poet") { rawData, error in
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
        
        switch self.type {
            case "poem":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemListCellId, for: indexPath) as! PoemListCell
                if let content = poemGroup?.data[indexPath.row]{
                    cell.titleLabel.text = content.name
                    cell.sentenceLabel.text = "\(String(describing: (content.sentence)))"
                }
                return cell
            case "tag":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemTagListCellId, for: indexPath) as! PoemsRowCell
                if let content = poemGroup?.data[indexPath.row]{
                    cell.titleLabel.text = content.name
                    cell.contentLabel.text = content.poetName
                    cell.sentenceLabel.text = "\(String(describing: (content.sentence)))"
                }
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemListCellId, for: indexPath) as! PoemListCell
                if let content = poemGroup?.data[indexPath.row]{
                    cell.titleLabel.text = content.name
                    cell.sentenceLabel.text = "\(String(describing: (content.sentence)))"
                }
                return cell
        }
        
        
        
        
        

        
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.height - 2*topBottomPadding - 2*lineSpacing)
        switch self.type {
        case "poem":
            return .init(width: view.frame.width-32, height: 100)
        case "tag":
            return .init(width: view.frame.width-32, height: 120)
        default:
            return .init(width: view.frame.width-32, height:100)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
