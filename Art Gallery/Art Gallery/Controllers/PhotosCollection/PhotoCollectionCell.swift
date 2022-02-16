//
//  PhotoCollectionCell.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 16.02.2022.
//

import UIKit
import SDWebImage

class PhotoCollectionCell: UICollectionViewCell {
    
    static let reuseId = "PhotoCell"
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["regular"]
            guard let imageURL = photoUrl, let url = URL(string: imageURL) else { return }
            photoImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoImageView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil // Delete old photo before reuse
    }
    
    // MARK: - SetupViews
    
    private func setupPhotoImageView() {
        self.addSubview(photoImageView)
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
