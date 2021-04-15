//
//  HomeController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 14.03.2021.
//

import UIKit

class HomeController: BaseController, UICollectionViewDelegateFlowLayout {
    
    let tagsId = "tagcellid"
    let categoryId = "categoryid"
    
    var feedData: OrderRawData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.backgroundColor = .white
        collectionView.register(TagsGroupCell.self, forCellWithReuseIdentifier: tagsId)
        collectionView.register(CategoryGroupCell.self, forCellWithReuseIdentifier: categoryId)
        collectionView.backgroundColor = .gray
        fetchData()
        collectionView.reloadData()
    }
    
    fileprivate func fetchData(){
        
        
            Service.shared.fetchHomeFeed { (rawData, error) in
                if let error = error{
                    // TODO: - Show error to the user
                    print("error while fetching app groups", error)
                    return
                }
                if let data = rawData{
                    self.feedData = data
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                
            }
        
            
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedData?.data?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagsId, for: indexPath) as! TagsGroupCell
            cell.titleLabel.text = feedData?.data?[indexPath.row].categoryName
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryId, for: indexPath) as! CategoryGroupCell
            cell.titleLabel.text = feedData?.data?[indexPath.row].categoryName
            cell.contentControlller.poemGroup = feedData?.data?[1]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagsId, for: indexPath) as! TagsGroupCell
            cell.titleLabel.text = feedData?.data?[indexPath.row].categoryName
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row{
        case 0:
            return .init(width: view.frame.width, height: 200 )
        case 1:
            return .init(width: view.frame.width, height: 380 )
        case 2:
            return .init(width: view.frame.width, height: 200 )
        
        default:
            return .init(width: view.frame.width, height: 150 )
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
