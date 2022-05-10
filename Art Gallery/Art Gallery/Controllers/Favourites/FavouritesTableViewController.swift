//
//  FavouritesTableViewController.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 17.02.2022.
//


import UIKit

class FavouritesTableViewController: UITableViewController {
    
    var likedPhotos = [LikedPhotos]()
    
    var obsever: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likedPhotos = LikedPhotos().getAllItems()
        setupTableView()
        
        obsever = NotificationCenter.default.addObserver(forName: NSNotification.Name("updateLikedPhotos"),
                                                         object: nil,
                                                         queue: .main,
                                                         using: { [weak self] notification in
            guard let object = notification.object as? [LikedPhotos] else { return }
            self?.likedPhotos = object
            self?.tableView.reloadData()
        })
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
        guard let unsplashPhoto = LikedPhotos().convertToUnsplashPhoto(photok: likedPhotos[indexPath.item].unsplashPhoto) else { return UITableViewCell() }
        cell.unsplashPhoto = unsplashPhoto 
        cell.nameLabel.text = unsplashPhoto.user.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedPhotos.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let unsplashPhoto = LikedPhotos().convertToUnsplashPhoto(photok: likedPhotos[indexPath.item].unsplashPhoto)
        present(DetailViewController(photo: unsplashPhoto), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}
