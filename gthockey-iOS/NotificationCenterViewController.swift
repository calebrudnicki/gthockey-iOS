//
//  NotificationCenterViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 2/9/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class NotificationCenterViewController: UIViewController {

    // MARK: Properties

    public var delegate: HomeControllerDelegate?

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

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        titleLabel.text = "Title"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    private let titleTextView: UITextView = {
        let titleTextView = UITextView()
        titleTextView.layer.borderWidth = 1.0
        titleTextView.layer.cornerRadius = 5.0
        titleTextView.font = UIFont(name: "HelveticaNeue", size: 24.0)
        titleTextView.layer.borderColor = UIColor.techNavy.cgColor
        titleTextView.textContainer.maximumNumberOfLines = 2
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        return titleTextView
    }()

    private let bodyLabel: UILabel = {
        let bodyLabel = UILabel()
        bodyLabel.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        bodyLabel.text = "Body"
        bodyLabel.adjustsFontSizeToFitWidth = true
        bodyLabel.numberOfLines = 1
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        return bodyLabel
    }()

    private let bodyTextView: UITextView = {
        let bodyTextView = UITextView()
        bodyTextView.layer.borderWidth = 1.0
        bodyTextView.layer.cornerRadius = 5.0
        bodyTextView.font = UIFont(name: "HelveticaNeue", size: 24.0)
        bodyTextView.layer.borderColor = UIColor.techNavy.cgColor
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        return bodyTextView
    }()

    private let sendNotificationButton = PillButton(title: "Send notification", backgroundColor: .techNavy, borderColor: .techNavy, isEnabled: false)

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationController()
        setupView()
    }

    // MARK: Config

    private func setupNavigationController() {
        navigationItem.title = "Notification Center"

        let menuButtonImage: UIImage?

        if #available(iOS 13.0, *){
            menuButtonImage = UIImage(systemName: "line.horizontal.3")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.label)
                .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        } else {
            menuButtonImage = UIImage(named: "MenuIconBlack")?.withRenderingMode(.alwaysOriginal)
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(menuButtonTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupView() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .gthBackgroundColor
            titleTextView.textColor = .label
            bodyTextView.textColor = .label
        } else {
            view.backgroundColor = .white
            titleTextView.textColor = .black
            bodyTextView.textColor = .black
        }

        titleTextView.delegate = self
        bodyTextView.delegate = self

        sendNotificationButton.addTarget(self, action: #selector(sendNotificationButtonTapped), for: .touchUpInside)

        view.addSubview(scrollView)
        scrollView.addSubviews([backgroundView, titleLabel, titleTextView,
                                bodyLabel, bodyTextView, sendNotificationButton])

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
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16.0),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            titleTextView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            titleTextView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            titleTextView.heightAnchor.constraint(equalToConstant: 80.0)
        ])

        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 16.0),
            bodyLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            bodyLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 8.0),
            bodyTextView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            bodyTextView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            bodyTextView.heightAnchor.constraint(equalTo: titleTextView.heightAnchor, multiplier: 3.0)
        ])

        NSLayoutConstraint.activate([
            sendNotificationButton.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: 16.0),
            sendNotificationButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            sendNotificationButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

    @objc private func validateTextFields() {
        guard
            let titleText = titleTextView.text,
            let bodyText = bodyTextView.text
        else { return }

        if titleText.count > 1 && bodyText.count > 1 {
            sendNotificationButton.isEnabled = true
        } else {
            sendNotificationButton.isEnabled = false
        }
    }

    @objc private func sendNotificationButtonTapped() {
        guard
            let titleText = titleTextView.text,
            let bodyText = bodyTextView.text
        else { return }

        sendNotificationButton.isLoading = true

        let alert = UIAlertController(title: titleText,
                                      message: bodyText,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Don't send", style: .destructive, handler: { action in
            self.sendNotificationButton.isLoading = false
        }))
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { action in
            UserManager().getAllUsersWithValidFCMToken(completion: { (usersWithValidFCMToken) in
                var tokens: [String] = []

                for user in usersWithValidFCMToken {
                    tokens.append(user.getFCMToken())
                }

                PushNotificationSender().sendNotification(to: tokens,
                                                          title: titleText,
                                                          body: bodyText,
                                                          completion: {
                                                            self.sendNotificationButton.isLoading = false
                                                            self.titleTextView.text = ""
                                                            self.bodyTextView.text = ""
                })
            })
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension NotificationCenterViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        validateTextFields()
    }

}
