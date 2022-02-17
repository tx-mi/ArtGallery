//
//  AboutView.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 17.02.2022.
//

import UIKit

class AboutView: UIView {
    
    private var photo: UnsplashPhoto!
    
    let starImageView: UIImageView = {
        let image = UIImage(systemName: "star")
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(photo: UnsplashPhoto) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.photo = photo
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.alpha = 0.8
        setupAboutView()
    }
    
    // MARK: - Setup Views
    private func setupAboutView() {

        let aboutLabel = UILabel()
        aboutLabel.lineBreakMode = .byTruncatingTail
        aboutLabel.numberOfLines = 9
        aboutLabel.textColor = .white
        aboutLabel.font = UIFont.systemFont(ofSize: 13, weight: .heavy)
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.text =  """
            
            Author: \(photo.user.name)
            
            Date: \(photo.width)
            
            Place: \(photo.height)
            
            Downloads: \(photo.likes)
            
            """
        self.addSubview(aboutLabel)
        
        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            aboutLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            aboutLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        
        setupStarImageView()
    }
    
    private func setupStarImageView() {
        self.addSubview(starImageView)
        
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            starImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
