//
//  BaseListController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 14.03.2021.
//

import UIKit

class BaseController: UICollectionViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
