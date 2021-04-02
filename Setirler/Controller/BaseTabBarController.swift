//
//  ViewController.swift
//  Setirler
//
//  Created by Didar Jelaletdinov on 13.03.2021.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: HomeController(),  image: #imageLiteral(resourceName: "home")),
            createNavController(viewController: UIViewController(), image: #imageLiteral(resourceName: "bookmark")),
            createNavController(viewController: UIViewController(),  image: #imageLiteral(resourceName: "search")),
            
        ]
        
    }

    fileprivate func createNavController(viewController: UIViewController, image: UIImage)-> UIViewController{
        
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = ""
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }

}

