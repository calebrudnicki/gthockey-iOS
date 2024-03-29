//
//  ManagerDetailViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 6/8/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class ManagerDetailViewController: GTHDetailViewController {

    // MARK: Properties
    
    private let actionImageView: UIImageView = {
        let actionImageView = UIImageView()
        actionImageView.contentMode = .scaleAspectFill
        actionImageView.isUserInteractionEnabled = true
        actionImageView.translatesAutoresizingMaskIntoConstraints = false
        return actionImageView
    }()
    
    private let shadowContainerView: UIView = {
        let shadowContainerView = UIView()
        shadowContainerView.layer.applySketchShadow(color: .red, alpha: 1.0, x: 0.0, y: 16.0, blur: 16.0, spread: 0.0)
        shadowContainerView.translatesAutoresizingMaskIntoConstraints = false
        return shadowContainerView
    }()

    private let lastNameLabel: UILabel = {
        let lastNameLabel = UILabel()
        lastNameLabel.textAlignment = .center
        lastNameLabel.font = UIFont.DINCondensed.bold.font(size: 36.0)
        lastNameLabel.textColor = .label
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return lastNameLabel
    }()

    private let positionLabel: UILabel = {
        let positionLabel = UILabel()
        positionLabel.textAlignment = .center
        positionLabel.font = UIFont.DINCondensed.bold.font(size: 36.0)
        positionLabel.textColor = UIColor.rosterDetailPositionColor
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        return positionLabel
    }()

    private let hometownLabel: UILabel = {
        let hometownLabel = UILabel()
        hometownLabel.textAlignment = .center
        hometownLabel.adjustsFontSizeToFitWidth = true
        hometownLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        hometownLabel.textColor = UIColor.rosterDetailHometownColor
        hometownLabel.translatesAutoresizingMaskIntoConstraints = false
        return hometownLabel
    }()

    private let schoolLabel: UILabel = {
        let schoolLabel = UILabel()
        schoolLabel.textAlignment = .center
        schoolLabel.adjustsFontSizeToFitWidth = true
        schoolLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        schoolLabel.textColor = UIColor.rosterDetailSchoolColor
        schoolLabel.translatesAutoresizingMaskIntoConstraints = false
        return schoolLabel
    }()
    
    private let detailsStackView: UIStackView = {
        let detailsStackView = UIStackView()
        detailsStackView.axis = .horizontal
        detailsStackView.spacing = 4.0
        detailsStackView.distribution = .fillProportionally
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        return detailsStackView
    }()

    private let bioLabel = HTMLTextView(frame: .zero)

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 14.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        secondaryLabel.font = UIFont.DINCondensed.bold.font(size: 36.0)
        secondaryLabel.textAlignment = .center
        secondaryLabel.sizeToFit()
        secondaryLabel.textColor = UIColor.rosterDetailNumberColor
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        primaryLabel.textColor = .label
        primaryLabel.textAlignment = .center
        primaryLabel.font = UIFont.DINCondensed.bold.font(size: 24.0)
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill",
                                     withConfiguration: UIImage.SymbolConfiguration(pointSize: 24.0)),
                             for: .normal)
        closeButton.tintColor = .label
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        actionImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionImageViewTapped)))

        view.addSubview(scrollView)
        
        detailsStackView.addArrangedSubview(hometownLabel)
        detailsStackView.addArrangedSubview(schoolLabel)
        
        scrollView.addSubviews([actionImageView, imageView, primaryLabel, lastNameLabel, positionLabel, secondaryLabel, detailsStackView, bioLabel, closeButton])

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
            actionImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            actionImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actionImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            actionImageView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: actionImageView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 128.0),
            imageView.heightAnchor.constraint(equalToConstant: 128.0)
        ])

        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.0),
            primaryLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24.0),
            primaryLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24.0),
            primaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor),
            lastNameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24.0),
            lastNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24.0),
            lastNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    
        NSLayoutConstraint.activate([
            positionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            positionLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -16.0),
            positionLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            secondaryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16.0),
            secondaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            secondaryLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailsStackView.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 16.0),
            detailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            detailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
        ])

        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: detailsStackView.bottomAnchor, constant: 16.0),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
            bioLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -32.0)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0)
        ])
    }

    // MARK: Setter

    public func set(with actionImageURL: URL, _ lastName: String, _ position: Position, _ hometown: String, _ school: String, _ bio: String) {
        actionImageView.sd_setImage(with: actionImageURL, placeholderImage: nil)
        lastNameLabel.text = lastName
        positionLabel.text = position.shortDescription
        hometownLabel.text = hometown
        schoolLabel.text = school
        bioLabel.text = bio
    }
    
    // MARK: Action
    
    @objc private func actionImageViewTapped() {
        let fullScreenImageViewController = FullScreenImageViewController()
        fullScreenImageViewController.set(with: actionImageView.image ?? UIImage())
        fullScreenImageViewController.modalPresentationStyle = .overFullScreen
        present(fullScreenImageViewController, animated: false, completion: nil)
    }

}
