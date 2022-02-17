//
//  PhotosCollectionView.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 16.02.2022.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    var networkDataFetcher = NetworkDataFetch()
    
    private let elementsPerRow: CGFloat = 2
    
    private let sectionInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    
    private var timer: Timer?
    
    private var photos = [UnsplashPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gallery"
        collectionView.backgroundColor = .black
        setupCollectionCells()
        setupSearchBar()
        
        // StartPage
        self.networkDataFetcher.fetchImages(searchTerm: "Hello") { [weak self] (searchResults) in
            guard let fetchedPhotos = searchResults else { return }
            self?.photos = fetchedPhotos
            self?.collectionView.reloadData()
            
            
        }
        
    }
    
    // MARK: - Setup UI elements
    
    private func setupCollectionCells() {
        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.reuseId)
        
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.searchBar.backgroundColor = .black
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.insetsLayoutMarginsFromSafeArea = true
        navigationItem.searchController = searchController
    }
    
    // MARK: - UICollectionViewDataSource UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.reuseId, for: indexPath) as! PhotoCollectionCell
        cell.backgroundColor = .lightGray
        cell.unsplashPhoto = photos[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        let tabbar = navigationController?.tabBarController as! MainTabBarController
        let navVC = tabbar.viewControllers?[1] as! UINavigationController
        let likesVC = navVC.topViewController as! FavouritesTableViewController
 
        present(DetailViewController(photo: photo, likesViewController: likesVC), animated: true)
    }
    
    
}


// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos
                self?.collectionView.reloadData()
            }
        })
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        let paddingSpace = sectionInsets.left * (elementsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let itemWidth = availableWidth / elementsPerRow
        let height = CGFloat(photo.height) * itemWidth / CGFloat(photo.width)
        return CGSize(width: itemWidth, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
}
