//
//  NewsDetailViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/24/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class NewsDetailViewController: UIViewController {

    // MARK: Properties
    
    var data: NewsCellData! {
        didSet {
            imageView.image = data.image
            dateLabel.text = data.date
            headlineLabel.text = data.title
        }
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        dateLabel.textColor = UIColor.newsDetailDateColor
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()

    let headlineLabel: UILabel = {
        let headlineLabel = UILabel()
        headlineLabel.numberOfLines = 0
        headlineLabel.font = UIFont.DINCondensed.bold.font(size: 36.0)
        headlineLabel.textColor = UIColor.newsDetailTitleColor
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        return headlineLabel
    }()

    private let bodyTextView = HTMLTextView(frame: .zero)
    
    let closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill",
                                     withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0)),
                             for: .normal)
        closeButton.tintColor = .label
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()

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

        view.addSubview(scrollView)
        scrollView.addSubviews([imageView, headlineLabel, dateLabel, bodyTextView, closeButton])

        updateViewConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.0),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4.0),
            headlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            headlineLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 16.0),
            bodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            bodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
            bodyTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -32.0)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 32.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0)
        ])
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: Setter

    public func set(with news: News) {
        bodyTextView.setText(with: news.getContent())
    }

    // MARK: Action

    @objc func imageViewTapped() {
        let fullScreenImageViewController = FullScreenImageViewController()
        fullScreenImageViewController.set(with: imageView.image ?? UIImage())
        fullScreenImageViewController.modalPresentationStyle = .overFullScreen
        present(fullScreenImageViewController, animated: false, completion: nil)
    }

    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }

}

extension NewsDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let frame = imageView.convert(imageView.frame, from: view)
        if frame.minY <= -152.0 { close() }
    }
    
}

