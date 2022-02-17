//
//  AboutView.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 17.02.2022.
//

import UIKit

class AboutView: UIView {
    
    private var photo: UnsplashPhoto!
    
    let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(photo: UnsplashPhoto) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.photo = photo
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.alpha = 0.8
        
        setupAboutView()
        setupHeartButton()
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
        
    }
    
    private func setupHeartButton() {
        self.addSubview(heartButton)
        
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            heartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
