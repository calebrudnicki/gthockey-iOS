//
//  CoachingStaffDetailViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 6/8/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class CoachingStaffDetailViewController: GTHDetailViewController {

    // MARK: Properties
    
    private var email: String?

    private let bodyTextView = HTMLTextView(frame: .zero)
    
    private let emailButton: UIButton = {
        let emailButton = UIButton()
        emailButton.contentHorizontalAlignment = .left
        emailButton.setTitleColor(.techNavy, for: .normal)
        emailButton.titleLabel?.font = UIFont.DINCondensed.bold.font(size: 24.0)
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        return emailButton
    }()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        secondaryLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        secondaryLabel.textColor = UIColor.newsDetailDateColor
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        primaryLabel.numberOfLines = 0
        primaryLabel.font = UIFont.DINCondensed.bold.font(size: 36.0)
        primaryLabel.textColor = UIColor.newsDetailTitleColor
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill",
                                     withConfiguration: UIImage.SymbolConfiguration(pointSize: 24.0)),
                             for: .normal)
        closeButton.tintColor = .label
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        bodyTextView.isUserInteractionEnabled = false
        
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        
        view.addSubview(scrollView)
        scrollView.addSubviews([imageView, primaryLabel, secondaryLabel, bodyTextView, emailButton, closeButton])

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
            secondaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.0),
            secondaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            secondaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor, constant: 4.0),
            primaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            primaryLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 16.0),
            bodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            bodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
        ])
        
        NSLayoutConstraint.activate([
            emailButton.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: 24.0),
            emailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            emailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
            emailButton.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -32.0)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0)
        ])
    }

    // MARK: Setter

    public func set(with coach: Coach) {
        email = coach.email
        
        bodyTextView.setText(with: coach.bio)
        emailButton.setTitle("Email Coach \(coach.lastName)", for: .normal)
    }
    
    // MARK: Private Functions
    
    @objc private func emailButtonTapped() {
        if let url = URL(string: "mailto:\(email!)") {
            UIApplication.shared.open(url)
        }
    }

}
