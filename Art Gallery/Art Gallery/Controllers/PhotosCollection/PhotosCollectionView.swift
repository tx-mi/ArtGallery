//
//  PhotosCollectionView.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 16.02.2022.
//

import UIKit
import SDWebImage

class PhotosCollectionViewController: UICollectionViewController {
    
    var networkDataFetcher = NetworkDataFetch()
    
    private var timer: Timer?
    
    private var photos = [UnsplashPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        setupCollectionCells()
        setupSearchBar()
        
        // StartPage
        self.networkDataFetcher.fetchImages(searchTerm: "Hello") { [weak self] (searchResults) in
            guard let fetchedPhotos = searchResults else { return }
            self?.photos = fetchedPhotos.results
            self?.collectionView.reloadData()
        }
        
    }
   
    // MARK: - Setup UI elements
    
    private func setupCollectionCells() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.reuseId)
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
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
    
    
}


// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.results
                self?.collectionView.reloadData()
            }
        })
        
    }
}

