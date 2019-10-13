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
        let closeButton = UIButton()
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.titleLabel?.numberOfLines = 0
        closeButton.titleLabel?.sizeToFit()
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(imageView)
        backgroundView.addSubview(closeButton)
        backgroundView.addSubview(firstNameLabel)
        backgroundView.addSubview(lastNameLabel)
        backgroundView.addSubview(numberLabel)

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
            closeButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 8.0),
            closeButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8.0)
        ])

        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8.0),
            firstNameLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            firstNameLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.75)
        ])

        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 4.0),
            lastNameLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            firstNameLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.75)
        ])

        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: firstNameLabel.trailingAnchor, constant: 12.0),
            numberLabel.bottomAnchor.constraint(equalTo: lastNameLabel.bottomAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])
    }

    public func set(with player: Player) {
        imageView.sd_setImage(with: player.getImageURL(), placeholderImage: nil)
        firstNameLabel.text = player.getFirstName()
        lastNameLabel.text = player.getLastName()
        numberLabel.text = "#\(player.getNumber())"
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}
