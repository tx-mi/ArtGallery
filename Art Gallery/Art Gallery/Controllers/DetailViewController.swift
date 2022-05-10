//
//  DetailViewController.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 09.05.2022.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    private var photo: UnsplashPhoto!
    
    private var cardStackView: CardStackView!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    init(photo: UnsplashPhoto?) {
        super.init(nibName: nil, bundle: nil)
        
        guard let coolPhoto = photo else { return }
        self.photo = coolPhoto
        cardStackView = CardStackView(photo: coolPhoto)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        setupScrollView()
        setupCardView()
    }
    
    // MARK: - Setup Views
    func setupScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    func setupCardView() {
        scrollView.addSubview(cardStackView)
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let height = CGFloat(photo.height) * CGFloat(view.frame.width - 16) / CGFloat(photo.width) + 85
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: height + 10)
        
        NSLayoutConstraint.activate([
            cardStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cardStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            cardStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            cardStackView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        updateStateOfHeartButton()
        cardStackView.heartButton.addTarget(self, action: #selector(didTapOnHeart(_:)), for: .touchUpInside)
    }
    
    func searchItem(photos: [LikedPhotos]) -> LikedPhotos? {
        for item in photos {
            if item.id == photo.id {
                return item
            }
        }
        return nil
    }
}

// MARK: - Setup Button
extension DetailViewController {
    
    func updateStateOfHeartButton() {
        if searchItem(photos: LikedPhotos().getAllItems()) != nil {
            cardStackView.heartButton.setImage(UIImage(named: "heart64.red.fill"), for: .normal)
        }
    }
    
    @objc func didTapOnHeart(_ sender: UIButton) {
        if sender.image(for: .normal) == UIImage(named: "heart64") {
            sender.setImage(UIImage(named: "heart64.red.fill"), for: .normal)
            createItem(id: photo.id)
        } else {
            sender.setImage(UIImage(named: "heart64"), for: .normal)
            deleteItem(item: searchItem(photos: LikedPhotos().getAllItems())!)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("updateLikedPhotos"),
                                        object: LikedPhotos().getAllItems())
    }
}

// MARK: - Core Data
extension DetailViewController {
    

    
    func createItem(id: String) {
        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        
        let newItem = LikedPhotos(context: managedContext)
        newItem.id = id
        newItem.unsplashPhoto = newItem.convertToData(photo: photo)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save item. \(error) \(error.userInfo)")
        }
        
    }
    
    func deleteItem(item: LikedPhotos) {
        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        
        managedContext.delete(item)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save item. \(error) \(error.userInfo)")
        }
    }
    
}
