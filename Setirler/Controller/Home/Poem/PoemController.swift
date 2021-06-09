//
//  PoemController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 2021/06/09.
//

import UIKit

class PoemController: BaseController, UICollectionViewDelegateFlowLayout {

    fileprivate var poemId: Int

    init(poemId: Int) {
    self.poemId = poemId
        super.init()
    }
    
    var poemCellId = "poemcellid"
    var detailCellId  = "detailCellId"

    var poem: PoemData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(PoemCell.self, forCellWithReuseIdentifier: poemCellId)
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        fetchData()
    }
    
    
    fileprivate func fetchData(){
        print(poemId)
        let urlString = "http://poem.djelaletdin.com/public/api/poem/5\(poemId)"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (result: PoemRawData?, error) in
            let poem = result?.data
            self.poem = poem
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemCellId, for: indexPath) as! PoemCell
        cell.poem = self.poem
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width-16-16, height: view.frame.height-16)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 0, right: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

