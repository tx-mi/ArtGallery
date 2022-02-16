//
//  PhotosCollectionView.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 16.02.2022.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    var networkDataFetcher = NetworkDataFetch()
    
    private var timer: Timer?
    
    private var photos = [UnsplashPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        setupCollectionCells()
        setupSearchBar()
    }
   
    // MARK: - Setup UI elements
    
    private func setupCollectionCells() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath)
        cell.backgroundColor = .systemPink
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

