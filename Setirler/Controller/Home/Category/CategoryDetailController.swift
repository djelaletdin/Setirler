//
//  CategoryDetailController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/25.
//

import UIKit

class CategoryDetailController: BaseController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let categoryDetailCell = "categoryDetailCell"
    fileprivate let footerCellId = "footerCellId"
    fileprivate var page = 1
    fileprivate var isPaginating = false
    var categoryGroup: CategoryRawData?
        
    var categoryId: Int?{
        didSet{
            fetchData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PoetDetailCell.self, forCellWithReuseIdentifier: categoryDetailCell)
        collectionView.register(LoadingFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId)
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.isScrollEnabled = false
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    

    
    func fetchData(){
        Service.shared.fetchCategoryDetails(id: self.categoryId ?? 0, page: self.page) { categoryRawData, error in
            if let error = error{
                // TODO: - Show error to the user
                print("error while fetching app groups", error)
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
    
    var didSelectHandler: ((CategoryData)->())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let category  = self.categoryGroup?.data[indexPath.row]{
            didSelectHandler?(category)
        }
    }

    
}

extension CategoryDetailController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryGroup?.data.count ?? 0
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath)
        return footer
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
