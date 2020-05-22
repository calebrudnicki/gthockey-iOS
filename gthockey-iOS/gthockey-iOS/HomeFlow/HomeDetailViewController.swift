//
//  HomeDetailViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/8/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class HomeDetailViewController: UIViewController {

    // MARK: Properties

    private weak var presentingViewConroller: UIViewController?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        dateLabel.textColor = UIColor.newsDetailDateColor
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()

    private let headlineLabel: UILabel = {
        let headlineLabel = UILabel()
        headlineLabel.numberOfLines = 0
        headlineLabel.font = UIFont.DINCondensed.bold.font(size: 36.0)
        headlineLabel.textColor = UIColor.newsDetailTitleColor
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        return headlineLabel
    }()

    private let bodyTextView = HTMLTextView(frame: .zero)

    private let articlesLabel: UILabel = {
        let otherArticlesLabel = UILabel()
        otherArticlesLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        otherArticlesLabel.textColor = UIColor.newsDetailDateColor
        otherArticlesLabel.text = "Also read..."
        otherArticlesLabel.translatesAutoresizingMaskIntoConstraints = false
        return otherArticlesLabel
    }()

    private let articlesStackView: UIStackView = {
        let articlesStackView = UIStackView()
        articlesStackView.axis = .horizontal
        articlesStackView.distribution = .fillEqually
        articlesStackView.spacing = 12.0
        articlesStackView.translatesAutoresizingMaskIntoConstraints = false
        return articlesStackView
    }()

    private var previousArticlePreview = ArticlePreviewView()
    private let nextArticlePreview = ArticlePreviewView()
    private let closeButton = FloatingCloseButton()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        presentingViewConroller = presentingViewController

        previousArticlePreview.delegate = self
        nextArticlePreview.delegate = self

        view.backgroundColor = .gthBackgroundColor

        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))

        articlesStackView.addArrangedSubview(previousArticlePreview)
        articlesStackView.addArrangedSubview(nextArticlePreview)

        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubviews([imageView, headlineLabel, dateLabel, bodyTextView,
                                    articlesLabel, articlesStackView, closeButton])

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
            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.0),
            dateLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            dateLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4.0),
            headlineLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            headlineLabel.trailingAnchor.constraint(lessThanOrEqualTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 16.0),
            bodyTextView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            bodyTextView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
        ])

        NSLayoutConstraint.activate([
            articlesLabel.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: 19.0),
            articlesLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            articlesLabel.trailingAnchor.constraint(lessThanOrEqualTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            articlesStackView.topAnchor.constraint(equalTo: articlesLabel.bottomAnchor, constant: 12.0),
            articlesStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            articlesStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            articlesStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -28.0)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
            closeButton.widthAnchor.constraint(equalToConstant: 32.0),
            closeButton.heightAnchor.constraint(equalToConstant: 32.0)
        ])
    }

    // MARK: Setter

    public func set(with news: News) {
        imageView.sd_setImage(with: news.getImageURL(), placeholderImage: nil)
        headlineLabel.text = news.getTitle()

        let formatter = DateFormatter()
        formatter.dateStyle = .long
        dateLabel.text = formatter.string(from: news.getDate())

        bodyTextView.setText(with: news.getContent())

        if let previousArticle = news.getPreviousArticle() {
            previousArticlePreview.set(with: previousArticle)
        }

        if let nextArticle = news.getNextArticle() {
            nextArticlePreview.set(with: nextArticle)
        }
    }

    // MARK: Action

    @objc func imageViewTapped() {
        let fullScreenImageViewController = FullScreenImageViewController()
        fullScreenImageViewController.set(with: imageView.image ?? UIImage())
        fullScreenImageViewController.modalPresentationStyle = .overFullScreen
        present(fullScreenImageViewController, animated: false, completion: nil)
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}

extension HomeDetailViewController: ArticlePreviewViewDelegate {

    func previewSelected(for article: News) {
        dismiss(animated: true, completion: {
            let homeDetailViewController = HomeDetailViewController()
            homeDetailViewController.set(with: article)
            self.presentingViewConroller!.present(homeDetailViewController, animated: true, completion: nil)
        })
    }

}
