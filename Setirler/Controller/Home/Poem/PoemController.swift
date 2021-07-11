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
    var tagsCellId  = "tagscellid"

    var poem: PoemData?
    
    let attributes = [NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Bold", size: 28)!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        collectionView.backgroundColor = .white
        collectionView.register(PoemCell.self, forCellWithReuseIdentifier: poemCellId)
        collectionView.register(PoemDetailCell.self, forCellWithReuseIdentifier: tagsCellId)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self;
        navigationItem.hidesBackButton = true
        
//         Makes the height of cell dynamic
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
  
        
    }
    
    
    fileprivate func fetchData(){
        print(poemId)
        let urlString = "http://poem.djelaletdin.com/public/api/poem/\(poemId)"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (result: PoemRawData?, error) in
            if let poemData = result?.data{
                self.poem = poemData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PoemController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: poemCellId, for: indexPath) as! PoemCell
            cell.poem = self.poem
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagsCellId, for: indexPath) as! PoemDetailCell
            cell.poem = self.poem
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return .init(width: view.frame.width-16-16, height: view.frame.height-16)
        }else{
            return .init(width: view.frame.width-16-16, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 0, right: 16)
    }
    
    
    
}

extension PoemController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
