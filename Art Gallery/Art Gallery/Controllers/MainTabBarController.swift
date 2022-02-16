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
        
        let photosVC = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        viewControllers = [
            createNavigationController(rootViewController: photosVC, title: "Photos", image: UIImage(named: "photos")),
            createNavigationController(rootViewController: DetailViewController(), title: "Favourites", image: UIImage(named: "heart")),
        ]
    }
    
    private func createNavigationController(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.navigationItem.searchController = UISearchController()
        return navigationVC
    }
}
