//
//  HomeController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 14.03.2021.
//

import UIKit

class HomeController: BaseController, UICollectionViewDelegateFlowLayout {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("asasd")
    }
    
    
    let tagsId = "tagcellid"
    let poemId = "poemID"
    let categoryId = "categoryid"
    let headerId = "headerCellId"
    
    var searchController = UISearchController(searchResultsController:  nil)
    
    var feedData: OrderRawData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        collectionView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        collectionView.register(TagsGroupCell.self, forCellWithReuseIdentifier: tagsId)
        collectionView.register(PoemGroupCell.self, forCellWithReuseIdentifier: poemId)
        collectionView.register(CategoryGroupCell.self, forCellWithReuseIdentifier: categoryId)
        collectionView?.register(SearchViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        
        
        fetchData()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc fileprivate func headerTapped(){
        let newViewController = SearchViewController()
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.pushViewController(newViewController, animated: false)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SearchViewHeader
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(headerTapped))
        header.addGestureRecognizer(tapGestureRecognizer)
        
        return header
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagsId, for: indexPath) as! TagsGroupCell
            cell.titleLabel.text = feedData?.data?[indexPath.row].categoryName
            cell.contentControlller.poemGroup = feedData?.data?[indexPath.row]
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryId, for: indexPath) as! CategoryGroupCell
            cell.titleLabel.text = feedData?.data?[indexPath.row].categoryName
            cell.contentControlller.poemGroup = feedData?.data?[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemId, for: indexPath) as! PoemGroupCell
            cell.titleLabel.text = feedData?.data?[indexPath.row].categoryName
            cell.contentControlller.poemGroup = feedData?.data?[indexPath.row]
            
            cell.contentControlller.didSelectHandler = { [weak self] poem in
                let destinationController  = PoemController(poemId: poem.id ?? 0)
                destinationController.navigationController?.title = poem.name
                self?.navigationController?.pushViewController(destinationController, animated: true)
            }
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row{
        case 0:
            return .init(width: view.frame.width, height: 190 )
        case 1:
            return .init(width: view.frame.width, height: 420 )
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
