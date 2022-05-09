//
//  DetailViewController.swift
//  Art Gallery
//
//  Created by Ramazan Abdulaev on 09.05.2022.
//

import UIKit

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
        
    }
    
}
