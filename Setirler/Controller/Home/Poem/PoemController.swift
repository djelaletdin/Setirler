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
    
    let attributes = [NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Bold", size: 26)!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        collectionView.backgroundColor = .white
        collectionView.register(PoemCell.self, forCellWithReuseIdentifier: poemCellId)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self;
        navigationItem.hidesBackButton = true
    }
    
    
    fileprivate func fetchData(){
        print(poemId)
        let urlString = "http://poem.djelaletdin.com/public/api/poem/\(poemId)"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (result: PoemRawData?, error) in
            if let poemData = result?.data{
                self.poem = poemData
                DispatchQueue.main.async {
                    self.title = poemData.name
                    self.collectionView.reloadData()
                }
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

extension PoemController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
