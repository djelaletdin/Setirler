//
//  SearchViewController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/05/29.
//

import UIKit

class SearchViewController: BaseController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    let searchBarId = "searchBarid"
    let searchResultId = "searchResultId"
    let emptySearchCellId = "emptySearchCellId"
    var timer: Timer?
    var searchResults: DataClass?
    
    var isSearched = false
    
    var progressIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.contentMode = .center
        return indicator
    }()

     func activityIndicatorTest() {
         
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        collectionView.register(SearchBarCell.self, forCellWithReuseIdentifier: searchBarId)
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: searchResultId)
        collectionView.register(EmptySearchCell.self, forCellWithReuseIdentifier: emptySearchCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearched{
            return 2
        }else{
            return 1
        }
    }

    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchBarId, for: indexPath) as! SearchBarCell
            cell.delegate = self
            cell.getButton.tag = indexPath.row
            cell.getButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
            cell.textField.setLeftIcon(progressIndicator)
            cell.textField.becomeFirstResponder()
            return cell
        } else {
                if let search = searchResults{
                    if search.poemNames.count == 0, search.poemSentences.count == 0{
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptySearchCellId, for: indexPath) as! EmptySearchCell
                        return cell
                    }else{
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchResultId, for: indexPath) as! SearchResultCell
                        return cell
                    }
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptySearchCellId, for: indexPath) as! EmptySearchCell
                    return cell
                }
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row{
            case 0:
                return .init(width: view.frame.width, height: 40 )
            case 1:
                if let search = searchResults{
                    if search.poemNames.count == 0, search.poemSentences.count == 0{
                        return .init(width: view.frame.width, height: 500 )
                    } else{
                        return .init(width: view.frame.width, height: view.frame.height-60 )
                    }
                } else{
                    return .init(width: view.frame.width, height: 500 )
                }
                
//                return .init(width: view.frame.width, height: view.frame.height-60 )
            default:
                return .init(width: view.frame.width, height: 150 )
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    @IBAction func cancelButtonPressed(){
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension SearchViewController: SearchBarCellDelegate {

    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: SearchBarCell) {
        
        self.isSearched = true
        
        if let text = textField.text, !text.isEmpty {
            progressIndicator.startAnimating()

            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (_) in
                Service.shared.fetchSearchTerm(searchTerm: text) {(result, error) in
                    
                    if let _ = error{return}
                    if let searchResults  = result{
                        self.searchResults = searchResults.data
                    }else{
                        self.progressIndicator.stopAnimating()
                    }
                    
                    DispatchQueue.main.async {
                        self.progressIndicator.stopAnimating()
                        self.collectionView.reloadData()
                    }
                }
            })
        }else{
            collectionView.reloadData()
        }
    }

    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: SearchBarCell)  -> Bool {
        return true
    }

}
