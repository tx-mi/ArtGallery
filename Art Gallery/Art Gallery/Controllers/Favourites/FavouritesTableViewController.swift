//
//  FavouritesTableViewController.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 17.02.2022.
//


import UIKit

class FavouritesTableViewController: UITableViewController {
    
    var likedPhotos = [UnsplashPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }

    // MARK: - Setup Views
    private func setupTableView() {
        tableView.register(FavouritesTableViewCell.self, forCellReuseIdentifier: FavouritesTableViewCell.reuseID)
    }
   
}

// MARK: - UITableViewDatasource UITableViewDelegate
extension FavouritesTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.reuseID, for: indexPath) as! FavouritesTableViewCell
        cell.unsplashPhoto = likedPhotos[indexPath.item]
        cell.nameLabel.text = likedPhotos[indexPath.item].user.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedPhotos.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let photo = photos[indexPath.item]
//        present(DetailViewController(photo: photo)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}
