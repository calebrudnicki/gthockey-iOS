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

    private let titleTextView: UITextView = {
        let titleTextView = UITextView()
        titleTextView.layer.borderWidth = 1.0
        titleTextView.layer.cornerRadius = 5.0
        titleTextView.font = UIFont(name: "HelveticaNeue", size: 24.0)
        titleTextView.textContainer.maximumNumberOfLines = 2
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        return titleTextView
    }()

    private let bodyTextView: UITextView = {
        let bodyTextView = UITextView()
        bodyTextView.layer.borderWidth = 1.0
        bodyTextView.layer.cornerRadius = 5.0
        bodyTextView.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        return bodyTextView
    }()

    private let sendNotificationButton = PillButton(title: "Send notification", backgroundColor: .techNavy, borderColor: .techNavy, isEnabled: true)

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
            view.backgroundColor = .systemBackground
            titleTextView.textColor = .label
            titleTextView.layer.borderColor = UIColor.label.cgColor
            bodyTextView.textColor = .label
            bodyTextView.layer.borderColor = UIColor.label.cgColor
        } else {
            view.backgroundColor = .white
            titleTextView.textColor = .black
            titleTextView.layer.borderColor = UIColor.black.cgColor
            bodyTextView.textColor = .black
            bodyTextView.layer.borderColor = UIColor.black.cgColor
        }

        sendNotificationButton.addTarget(self, action: #selector(sendNotificationButtonTapped), for: .touchUpInside)

        view.addSubview(scrollView)
        scrollView.addSubviews([backgroundView, titleTextView, bodyTextView, sendNotificationButton])

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
            titleTextView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16.0),
            titleTextView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            titleTextView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            titleTextView.heightAnchor.constraint(equalToConstant: 80.0)
        ])

        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 12.0),
            bodyTextView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            bodyTextView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            bodyTextView.heightAnchor.constraint(equalTo: titleTextView.heightAnchor, multiplier: 3.0)
        ])

        NSLayoutConstraint.activate([
            sendNotificationButton.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: 12.0),
            sendNotificationButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            sendNotificationButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])
    }

    // MARK: Action

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }

    @objc private func sendNotificationButtonTapped() {
        AdminHelper().getAllUsersWithValidFCMToken(completion: { (usersWithValidFCMToken, error) in

            print(usersWithValidFCMToken.forEach { print($0.getFirstName(), $0.getFCMToken()) })
            print(usersWithValidFCMToken.count)

            var tokens: [String] = []

            for user in usersWithValidFCMToken {
                tokens.append(user.getFCMToken())
            }
//            let tokens = usersWithValidFCMToken.forEach { return $0.getFCMToken() }

            PushNotificationSender().sendPushNotification(to: tokens,
                                                          title: self.titleTextView.text ?? "GT Hockey",
                                                          body: self.bodyTextView.text ?? "This is a test of the GT Hockey notification system", completion: {
            })
        })

//        AdminHelper().setForAllUsers(category: "appIcon", value: "Buzz", nilValues: ["RamblinReck", "HeritageT"], completion: {
//            print("done")
//        })
    }
    
}
