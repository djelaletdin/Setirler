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
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchResultId, for: indexPath) as! SearchResultCell
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
    
    @IBAction func cancelButtonPressed(){
        print("hello")
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension SearchViewController: SearchBarCellDelegate {

    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: SearchBarCell) {
        if let indexPath = collectionView.indexPath(for: cell), let text = textField.text {
            print("textField text: \(text) from cell: \(indexPath))")
//            textFieldsTexts[indexPath] = texteererererer
        }
    }

    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: SearchBarCell)  -> Bool {
        print("Validation action in textField from cell: \(String(describing: collectionView.indexPath(for: cell)))")
        return true
    }

}
