//
//  HomeController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 14.03.2021.
//

import UIKit

class HomeController: BaseController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellid"
    var feedData = [Datum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.backgroundColor = .white
        collectionView.register(CategoryGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .gray
        fetchData()
    }
    
    fileprivate func fetchData(){
        
        Service.shared.fetchHomeFeed { (rawData, error) in
            if let error = error{
                // TODO: - Show error to the user
                print("error while fetching app groups", error)
                return
            }
            
            if let data = rawData?.data{
                self.feedData = data
            }
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryGroupCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row{
        case 0:
            return .init(width: view.frame.width, height: 150 )
        case 1:
            return .init(width: view.frame.width, height: 300 )
        case 2:
            return .init(width: view.frame.width, height: 500 )
        case 3:
            return .init(width: view.frame.width, height: 500 )
        default:
            return .init(width: view.frame.width, height: 150 )
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
