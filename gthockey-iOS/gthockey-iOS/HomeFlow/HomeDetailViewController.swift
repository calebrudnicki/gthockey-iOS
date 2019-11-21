//
//  HomeDetailViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/8/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class HomeDetailViewController: UIViewController, UITextViewDelegate{

    // MARK: Properties

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

    private let closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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

    private let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .techGold
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()

    private let bodyContainer: UILabel = {
        let bodyContainer = UILabel()
        bodyContainer.sizeToFit()
        bodyContainer.isUserInteractionEnabled = true
        bodyContainer.translatesAutoresizingMaskIntoConstraints = false
        return bodyContainer
    }()

    private let bodyTextView: UITextView = {
        let bodyTextView = UITextView()
        bodyTextView.isScrollEnabled = false
        bodyTextView.isEditable = false
        bodyTextView.dataDetectorTypes = .link
        bodyTextView.font = UIFont(name: "Georgia", size: 20.0)
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        return bodyTextView
    }()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        var closeButtonImage: UIImage?

        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
            closeButtonImage = UIImage(named: "CloseButtonWhite")?.withRenderingMode(.alwaysOriginal)
        } else {
            view.backgroundColor = .white
            closeButtonImage = UIImage(named: "CloseButtonBlack")?.withRenderingMode(.alwaysOriginal)
        }

        closeButton.setImage(closeButtonImage, for: .normal)
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))

        bodyContainer.addSubview(bodyTextView)

        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubviews([imageView, closeButton, headlineLabel, dateLabel, separatorView, bodyContainer])

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
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12.0),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            closeButton.widthAnchor.constraint(equalToConstant: 32.0),
            closeButton.heightAnchor.constraint(equalToConstant: 32.0)
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
            separatorView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12.0),
            separatorView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            separatorView.widthAnchor.constraint(equalTo: dateLabel.widthAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0)
        ])

        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: bodyContainer.topAnchor),
            bodyTextView.leadingAnchor.constraint(equalTo: bodyContainer.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: bodyContainer.trailingAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: bodyContainer.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            bodyContainer.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 12.0),
            bodyContainer.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            bodyContainer.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            bodyContainer.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -28.0)
        ])
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: Setter

    public func set(with news: News) {
        imageView.sd_setImage(with: news.getImageURL(), placeholderImage: nil)
        headlineLabel.text = news.getTitle()

        let formatter = DateFormatter()
        formatter.dateStyle = .long
        dateLabel.text = formatter.string(from: news.getDate())

        let attributedString = news.getContent().htmlToAttributedString?.mutableCopy() as! NSMutableAttributedString
        attributedString.addAttribute(.font, value: UIFont(name: "Georgia", size: 20.0)!, range: NSRange(location: 0, length: attributedString.length))
        if #available(iOS 13.0, *) {
            attributedString.addAttribute(.foregroundColor, value: UIColor.label, range: NSRange(location: 0, length: attributedString.length))
        }
        bodyTextView.attributedText = attributedString
        bodyTextView.backgroundColor = self.view.backgroundColor
    }

    // MARK: Action

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
