//
//  TagController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/07/11.
//

import UIKit

class TagController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
//    init(){
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        super.init(collectionViewLayout: layout)
//        collectionView.decelerationRate = .fast
//    }

    
    var rootView: PoemController?
    
    let cellId = "Tagcell"
    var tags: [Tag]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(named: "MainBackground")
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
           flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
         }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 50)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationController  = TagViewController(tagId: tags?[indexPath.row].id ?? 1)
        destinationController.navTitleLabel.text = tags?[indexPath.row].name
        destinationController.tag = tags?[indexPath.row]
        rootView?.navigationController?.pushViewController(destinationController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TagCell
        cell.tagNameLabel.text = tags?[indexPath.row].name
        return cell
    }
    
    
    


    
}
