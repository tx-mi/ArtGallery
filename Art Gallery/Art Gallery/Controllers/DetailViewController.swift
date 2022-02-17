//
//  DetailViewController.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 16.02.2022.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var unsplashPhoto: UnsplashPhoto!
    
    var likesVC: FavouritesTableViewController!
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var aboutView: AboutView!
    
    init(photo: UnsplashPhoto?, likesViewController: FavouritesTableViewController) {
        super.init(nibName: nil, bundle: nil)
        
        guard let coolPhoto = photo else { return }
        self.unsplashPhoto = coolPhoto
        self.aboutView = AboutView(photo: coolPhoto)
        self.likesVC = likesViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favourites"
        view.backgroundColor = .black
        view.layer.cornerRadius = 5.0
        
        
        setupPhotoImageView()
        setupAboutView()
        updateHeartButtonState()
    }
    
    // MARK: - Setup Views
    private func setupPhotoImageView() {
        view.addSubview(photoImageView)
        
        let height = CGFloat(unsplashPhoto.height) * CGFloat(view.frame.width - 16) / CGFloat(unsplashPhoto.width)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -20),
            photoImageView.heightAnchor.constraint(equalToConstant: height),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        let photoUrl = unsplashPhoto.urls["regular"]
        guard let imageURL = photoUrl, let url = URL(string: imageURL) else { return }
        photoImageView.sd_setImage(with: url, completed: nil)
        
    }
    
    func setupAboutView() {
        view.addSubview(aboutView)
        
        aboutView.layer.cornerRadius = 7.0
        NSLayoutConstraint.activate([
            aboutView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            aboutView.heightAnchor.constraint(equalToConstant: 150),
            aboutView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            aboutView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor)
        ])
        
        aboutView.heartButton.addTarget(self, action: #selector(didTapOnHeart), for: .touchUpInside)
    }
    
    @objc private func didTapOnHeart(sender: UIButton) {
        
        guard sender == aboutView.heartButton else { return }
        if sender.image(for: .normal) == UIImage(systemName: "heart") {
            likesVC.photos.append(unsplashPhoto)
            likesVC.tableView.reloadData()
        } else {
            let alertController = UIAlertController(title: "You have already liked this photo!",
                                                    message: "Want to remove from favourites?",
                                                    preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Remove", style: .default) { (_) in
                let countPhotos = self.likesVC.photos.count
                if countPhotos == 0 { return }
                self.likesVC.photos.remove(at: 0)
                self.updateHeartButtonState()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        }
        updateHeartButtonState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Search in favourites
extension DetailViewController {
    
    func hasInLikes() -> Bool {
        for picture in likesVC.photos {
            if picture.id == unsplashPhoto.id {
                return true
            }
        }
        return false
    }
    
    func updateHeartButtonState() {
        if !hasInLikes() {
            aboutView.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            aboutView.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
}
