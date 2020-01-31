//
//  GameCenterViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 1/30/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class GameCenterViewController: UIViewController {

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
    
//    private let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()

    private let shopRestrictedOptionsView = ShopRestrictedOptionsView()

    private let opponentOptionsStackView: UIStackView = {
        let opponentOptionsStackView = UIStackView()
        opponentOptionsStackView.axis = .vertical
        opponentOptionsStackView.distribution = .equalCentering
        opponentOptionsStackView.spacing = 8.0
        opponentOptionsStackView.translatesAutoresizingMaskIntoConstraints = false
        return opponentOptionsStackView
    }()
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationController()
        setupView()
    }

    private func setupNavigationController() {
        navigationItem.title = "Game Center"

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
        } else {
            view.backgroundColor = .white
        }

        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)

        backgroundView.addSubviews([opponentOptionsStackView])

        updateViewConstraints()
    }

    public func set() {
        let shopRestrictedOptionsView = ShopRestrictedOptionsView()
        shopRestrictedOptionsView.set()
        shopRestrictedOptionsView.delegate = self
        opponentOptionsStackView.addArrangedSubview(shopRestrictedOptionsView)
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
            opponentOptionsStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 12.0),
            opponentOptionsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            opponentOptionsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

    }

    // MARK: Actions

    @objc private func menuButtonTapped() {
        delegate?.handleMenuToggle(forMainMenuOption: nil)
    }
    
}

extension GameCenterViewController: ShopRestrictedOptionsViewDelegate {

    func didSelect(option: String, for category: String) {
        print(option, category)
    }

}
