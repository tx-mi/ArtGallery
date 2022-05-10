//
//  CardStackView.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 09.05.2022.
//

import UIKit


class CardStackView: UIStackView {
    private var photo: UnsplashPhoto!
    
    let heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.layer.cornerRadius = button.bounds.size.width / 2 + 5
        button.clipsToBounds = true
        button.setImage(UIImage(named: "heart64"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 15, weight: .light)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(photo: UnsplashPhoto) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.photo = photo
        setupStackView()
        setupImageView()
        setupDescription()
   }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8.0
    }
    
    // MARK: - Setup Views
    func setupStackView() {
        self.axis = .vertical
        self.alignment = .center
        self.spacing = 10
        self.distribution = .fill
        self.backgroundColor = .darkGray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupImageView() {
        self.addArrangedSubview(imageView)
        
        let photoUrl = photo.urls["regular"]
        guard let imageURL = photoUrl, let url = URL(string: imageURL) else { return }
        imageView.sd_setImage(with: url, completed: nil)
        
        imageView.addSubview(heartButton)
        NSLayoutConstraint.activate([
            heartButton.widthAnchor.constraint(equalToConstant: 42),
            heartButton.heightAnchor.constraint(equalToConstant: 42),
            heartButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            heartButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10)
        ])
    }
    
    func setupDescription() {
        self.addArrangedSubview(usernameLabel)
        self.addArrangedSubview(dateLabel)
        
        usernameLabel.text = photo.user.username
        dateLabel.text = convertDate(inputDate: photo.created_at)
        self.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 10)))
    }
    
}

// MARK: - Date
extension CardStackView {
    
    private func convertDate(inputDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if  let dateLong = dateFormatter.date(from: inputDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: dateLong)
        }
        
        return ""
    }
    
}

