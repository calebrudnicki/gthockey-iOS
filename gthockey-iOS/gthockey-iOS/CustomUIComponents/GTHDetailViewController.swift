//
//  GTHDetailViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/26/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class GTHDetailViewController: UIViewController {

    // MARK: Properties
    
    var data: GTHCellData! {
        didSet {
            imageView.image = data.image
            primaryLabel.text = data.primaryLabel
            secondaryLabel.text = data.secondaryLabel
        }
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    public var imageView = UIImageView()
    public var primaryLabel = UILabel()
    public var secondaryLabel = UILabel()
    public var closeButton = UIButton()
    
//    let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.isUserInteractionEnabled = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
//    let dateLabel: UILabel = {
//        let dateLabel = UILabel()
//        dateLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
//        dateLabel.textColor = UIColor.newsDetailDateColor
//        dateLabel.translatesAutoresizingMaskIntoConstraints = false
//        return dateLabel
//    }()
    
//    let headlineLabel: UILabel = {
//        let headlineLabel = UILabel()
//        headlineLabel.numberOfLines = 0
//        headlineLabel.font = UIFont.DINCondensed.bold.font(size: 36.0)
//        headlineLabel.textColor = UIColor.newsDetailTitleColor
//        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
//        return headlineLabel
//    }()
    
//    private let bodyTextView = HTMLTextView(frame: .zero)
//
//    let closeButton: UIButton = {
//        let closeButton = UIButton()
//        closeButton.setImage(UIImage(systemName: "xmark.circle.fill",
//                                     withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0)),
//                             for: .normal)
//        closeButton.tintColor = .label
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
//        return closeButton
//    }()
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gthBackgroundColor
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        
        let backSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(close))
        backSwipe.edges = .left
        view.addGestureRecognizer(backSwipe)
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
//
//        view.addSubview(scrollView)
//        scrollView.addSubviews([imageView, headlineLabel, dateLabel, bodyTextView, closeButton])
        
//        updateViewConstraints()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Setter
    
//    public func set(with news: News) {
//        bodyTextView.setText(with: news.content)
//    }
//    
//    // MARK: Action
//    
    @objc func imageViewTapped() {
        let fullScreenImageViewController = FullScreenImageViewController()
        fullScreenImageViewController.set(with: imageView.image ?? UIImage())
        fullScreenImageViewController.modalPresentationStyle = .overFullScreen
        present(fullScreenImageViewController, animated: false, completion: nil)
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension GTHDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let frame = imageView.convert(imageView.frame, from: view)
        if frame.minY <= -152.0 { close() }
    }
    
}
