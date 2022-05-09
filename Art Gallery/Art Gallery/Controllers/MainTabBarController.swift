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
        let favouritesVC = FavouritesTableViewController()
        
        viewControllers = [
            createNavigationController(rootViewController: photosVC,
                                       title: "Gallery",
                                       image: UIImage(named: "photos")),
            createNavigationController(rootViewController: favouritesVC,
                                       title: "Favourites",
                                       image: UIImage(named: "heart"))
        ]
    }
    
    private func createNavigationController(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        rootViewController.title = title
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.navigationBar.backgroundColor = .black
        return navigationVC
    }
}
