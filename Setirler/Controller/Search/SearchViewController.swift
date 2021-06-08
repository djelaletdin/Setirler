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
    var timer: Timer?
    var searchResults = [SearchDatum]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        collectionView.register(SearchBarCell.self, forCellWithReuseIdentifier: searchBarId)
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: searchResultId)
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
        return 2
    }

    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchBarId, for: indexPath) as! SearchBarCell
            cell.delegate = self
            cell.getButton.tag = indexPath.row
            cell.getButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
            cell.textField.becomeFirstResponder()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchResultId, for: indexPath) as! SearchResultCell
            return cell
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row{
            case 0:
                return .init(width: view.frame.width, height: 40 )
            case 1:
                return .init(width: view.frame.width, height: view.frame.height-40 )
            default:
                return .init(width: view.frame.width, height: 150 )
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    @IBAction func cancelButtonPressed(){
        print("hello")
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension SearchViewController: SearchBarCellDelegate {

    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: SearchBarCell) {
        
        
        
        if let text = textField.text {
            print("textField text: \(text)")

            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (_) in
                Service.shared.fetchSearchTerm(searchTerm: text) {(result, error) in
                    
                    print("textField text: \(text)")

                    if let _ = error{return}
                    if let searchResults  = result{
                        self.searchResults = searchResults.data

                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            })
            
        }
    }

    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: SearchBarCell)  -> Bool {
        return true
    }

}
