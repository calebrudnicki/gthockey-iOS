//
//  RosterDetailViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/11/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage

class RosterDetailViewController: UIViewController {

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

    private let firstNameLabel: UILabel = {
        let firstNameLabel = UILabel()
        firstNameLabel.numberOfLines = 0
        firstNameLabel.sizeToFit()
        firstNameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 24)
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return firstNameLabel
    }()

    private let lastNameLabel: UILabel = {
        let lastNameLabel = UILabel()
        lastNameLabel.numberOfLines = 0
        lastNameLabel.sizeToFit()
        lastNameLabel.font = UIFont(name: "Helvetica Neue", size: 36)
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return lastNameLabel
    }()

    private let numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.numberOfLines = 0
        numberLabel.textAlignment = .right
        numberLabel.sizeToFit()
        numberLabel.font = UIFont(name: "Helvetica Neue", size: 36)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberLabel
    }()

    private let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .techGold
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()

    private let positionLabel: UILabel = {
        let positionLabel = UILabel()
        positionLabel.numberOfLines = 0
        positionLabel.sizeToFit()
        positionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        return positionLabel
    }()

    private let hometownLabel: UILabel = {
        let hometownLabel = UILabel()
        hometownLabel.numberOfLines = 0
        hometownLabel.sizeToFit()
        hometownLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        hometownLabel.translatesAutoresizingMaskIntoConstraints = false
        return hometownLabel
    }()

    private let schoolLabel: UILabel = {
        let schoolLabel = UILabel()
        schoolLabel.numberOfLines = 0
        schoolLabel.sizeToFit()
        schoolLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        schoolLabel.translatesAutoresizingMaskIntoConstraints = false
        return schoolLabel
    }()

    private let bioLabel: UILabel = {
        let bioLabel = UILabel()
        bioLabel.numberOfLines = 0
        bioLabel.sizeToFit()
        bioLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        return bioLabel
    }()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        var closeButtonImage: UIImage?

        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
            closeButtonImage = UIImage(systemName: "xmark.circle.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.label)
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 40.0, weight: .bold))
        } else {
            view.backgroundColor = .white
            closeButtonImage = UIImage(named: "CloseButtonBlack")?.withRenderingMode(.alwaysOriginal)
        }

        closeButton.setImage(closeButtonImage, for: .normal)
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))

        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubviews([imageView, closeButton, firstNameLabel, lastNameLabel, numberLabel, separatorView,
                                    positionLabel, hometownLabel, schoolLabel, bioLabel])

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
            firstNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8.0),
            firstNameLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            firstNameLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 4.0),
            lastNameLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
        ])

        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 4.0),
            numberLabel.leadingAnchor.constraint(equalTo: lastNameLabel.trailingAnchor, constant: 12.0),
            numberLabel.bottomAnchor.constraint(equalTo: lastNameLabel.bottomAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 12.0),
            separatorView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            separatorView.widthAnchor.constraint(equalTo: lastNameLabel.widthAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0)
        ])

        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 12.0),
            positionLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            positionLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            hometownLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 8.0),
            hometownLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            hometownLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            schoolLabel.topAnchor.constraint(equalTo: hometownLabel.bottomAnchor, constant: 8.0),
            schoolLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            schoolLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: schoolLabel.bottomAnchor, constant: 12.0),
            bioLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            bioLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            bioLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -28.0)
        ])
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: Setter

    public func set(with player: Player) {
        imageView.sd_setImage(with: player.getImageURL(), placeholderImage: nil)
        firstNameLabel.text = player.getFirstName()
        lastNameLabel.text = player.getLastName()
        numberLabel.text = "#\(player.getNumber())"
        positionLabel.text = player.getPositionLong()
        hometownLabel.text = player.getHometown()
        schoolLabel.text = player.getSchool()
        bioLabel.text = player.getBio()
    }

    // MARK: Action

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}
