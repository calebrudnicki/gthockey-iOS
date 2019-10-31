//
//  MenuTableViewFooter.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/23/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MenuTableViewFooter: UIView {

    // MARK: Properties

    private let iconStack: UIStackView = {
        let iconStack = UIStackView()
        iconStack.axis = .horizontal
        iconStack.alignment = .center
        iconStack.distribution = .fillEqually
        iconStack.spacing = 8.0
        iconStack.translatesAutoresizingMaskIntoConstraints = false
        return iconStack
    }()

    private let instagramButton: UIButton = {
        let instagramButton = UIButton(type: .custom)
        let instagramImage = UIImage(named: "InstagramIcon")?.withRenderingMode(.alwaysOriginal)
        instagramButton.setImage(instagramImage, for: .normal)
        instagramButton.translatesAutoresizingMaskIntoConstraints = false
        return instagramButton
    }()

    private let twitterButton: UIButton = {
        let twitterButton = UIButton(type: .custom)
        let twitterImage = UIImage(named: "TwitterIcon")?.withRenderingMode(.alwaysOriginal)
        twitterButton.setImage(twitterImage, for: .normal)
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        return twitterButton
    }()

    private let facebookButton: UIButton = {
        let facebookButton = UIButton(type: .custom)
        let facebookImage = UIImage(named: "FacebookIcon")?.withRenderingMode(.alwaysOriginal)
        facebookButton.setImage(facebookImage, for: .normal)
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        return facebookButton
    }()

    private let versionLabel: UILabel = {
        let versionLabel = UILabel()
        versionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        versionLabel.text = "Made in ATL | Version 1.0"
        versionLabel.adjustsFontSizeToFitWidth = true
        versionLabel.numberOfLines = 1
        versionLabel.textAlignment = .center
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.textColor = .gray
        versionLabel.sizeToFit()
        return versionLabel
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        instagramButton.addTarget(self, action: #selector(instagramButtonTapped), for: .touchUpInside)
        twitterButton.addTarget(self, action: #selector(twitterButtonTapped), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(facebookButtonTapped), for: .touchUpInside)

        iconStack.addArrangedSubview(instagramButton)
        iconStack.addArrangedSubview(twitterButton)
        iconStack.addArrangedSubview(facebookButton)
        
        addSubviews([iconStack, versionLabel])
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            iconStack.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            iconStack.leadingAnchor.constraint(equalTo: versionLabel.leadingAnchor),
            iconStack.trailingAnchor.constraint(equalTo: versionLabel.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            versionLabel.topAnchor.constraint(equalTo: iconStack.bottomAnchor, constant: 16.0),
            versionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            versionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 12.0),
            versionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12.0),
            versionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: Actions

    @objc private func instagramButtonTapped() {
        openSocialMedia(with: NSURL(string: "instagram://user?username=gthockey")!, NSURL(string: "https://instagram.com/gthockey")!)
    }

    @objc private func twitterButtonTapped() {
        openSocialMedia(with: NSURL(string: "twitter://user?screen_name=GT_Hockey")!, NSURL(string: "https://twitter.com/GT_Hockey")!)
    }

    @objc private func facebookButtonTapped() {
        openSocialMedia(with: NSURL(string: "fb://profile/85852244494")!, NSURL(string: "https://facebook.com/GeorgiaTechHockey")!)
    }

    private func openSocialMedia(with appURL: NSURL, _ webURL: NSURL) {
        let application = UIApplication.shared

        if application.canOpenURL(appURL as URL) {
             application.open(appURL as URL)
        } else {
             application.open(webURL as URL)
        }
    }

}
