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

    private let headlineLabel: UILabel = {
        let headlineLabel = UILabel()
        headlineLabel.numberOfLines = 0
        headlineLabel.sizeToFit()
        headlineLabel.font = UIFont(name: "HelveticaNeue-Light", size: 36.0)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        return headlineLabel
    }()

    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.numberOfLines = 0
        dateLabel.sizeToFit()
        dateLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()

    private let separatorView1: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .techGold
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()

    private let bodyTextView = HTMLTextView(frame: .zero)

    private let separatorView2: UIView = {
        let separatorView2 = UIView()
        separatorView2.backgroundColor = .techGold
        separatorView2.translatesAutoresizingMaskIntoConstraints = false
        return separatorView2
    }()

    private let articlesLabel: UILabel = {
        let otherArticlesLabel = UILabel()
        otherArticlesLabel.numberOfLines = 0
        otherArticlesLabel.sizeToFit()
        otherArticlesLabel.font = UIFont(name: "HelveticaNeue", size: 24.0)
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

    private let previousArticlePreview = ArticlePreviewView()
    private let nextArticlePreview = ArticlePreviewView()
    private let closeButton = FloatingCloseButton()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        presentingViewConroller = presentingViewController

        previousArticlePreview.delegate = self
        nextArticlePreview.delegate = self

        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))

        articlesStackView.addArrangedSubview(previousArticlePreview)
        articlesStackView.addArrangedSubview(nextArticlePreview)

        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubviews([imageView, headlineLabel, dateLabel, separatorView1, bodyTextView,
                                    separatorView2, articlesLabel, articlesStackView, closeButton])

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
            headlineLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8.0),
            headlineLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            headlineLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24.0)
        ])

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 8.0),
            dateLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            separatorView1.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12.0),
            separatorView1.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            separatorView1.widthAnchor.constraint(equalTo: dateLabel.widthAnchor),
            separatorView1.heightAnchor.constraint(equalToConstant: 1.0)
        ])

        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: separatorView1.bottomAnchor, constant: 9.0),
            bodyTextView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 9.0),
            bodyTextView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -9.0),
        ])

        NSLayoutConstraint.activate([
            separatorView2.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: 9.0),
            separatorView2.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            separatorView2.widthAnchor.constraint(equalTo: articlesLabel.widthAnchor),
            separatorView2.heightAnchor.constraint(equalToConstant: 1.0)
        ])

        NSLayoutConstraint.activate([
            articlesLabel.topAnchor.constraint(equalTo: separatorView2.bottomAnchor, constant: 12.0),
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

    func articlePreviewSelected(for article: News) {
        dismiss(animated: true, completion: {
            let homeDetailViewController = HomeDetailViewController()
            homeDetailViewController.set(with: article)
            self.presentingViewConroller!.present(homeDetailViewController, animated: true, completion: nil)
        })
    }

}
