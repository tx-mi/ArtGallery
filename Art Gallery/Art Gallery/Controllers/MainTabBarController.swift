//
//  MainTabBarController.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 16.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.backgroundColor = .black
        
        let photosVC = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        viewControllers = [
            createNavigationController(rootViewController: photosVC, title: "Photos", image: UIImage(named: "photos"))
        ]
    }
    
    private func createNavigationController(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.navigationBar.backgroundColor = .black
        return navigationVC
    }
}
