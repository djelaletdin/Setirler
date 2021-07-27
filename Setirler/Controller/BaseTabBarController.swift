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
        
        
        tabBar.tintColor = UIColor(named: "FontColor")
        
        viewControllers = [
            createNavController(viewController: HomeController(),  image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home-selected")),
            createNavController(viewController: UIViewController(), image: #imageLiteral(resourceName: "bookmark"), selectedImage: #imageLiteral(resourceName: "bookmark-selected")),
            createNavController(viewController: UIViewController(),  image: #imageLiteral(resourceName: "poets"),  selectedImage: #imageLiteral(resourceName: "poets-selected")),
            
        ]
        
    }

    fileprivate func createNavController(viewController: UIViewController, image: UIImage, selectedImage: UIImage)-> UIViewController{
        
        
        
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.view.backgroundColor = UIColor(named: "MainBackground")
        navController.tabBarItem.image = image
        navController.tabBarItem?.title = "Tab"
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarController?.tabBar.barTintColor = .clear
        return navController
    }

}

