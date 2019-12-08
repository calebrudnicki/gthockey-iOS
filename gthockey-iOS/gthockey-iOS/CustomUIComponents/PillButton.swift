//
//  PillButton.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/13/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class PillButton: UIButton {

    override var isEnabled: Bool {
        didSet{
            self.alpha = self.isEnabled ? 1.0 : 0.35
        }
    }

    override var isHighlighted: Bool {
        didSet{
            self.titleLabel?.alpha = self.isHighlighted ? 0.35 : 1.0
        }
    }

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        if #available(iOS 13.0, *) {
            layer.shadowColor = UIColor.label.cgColor
        } else {
            layer.shadowColor = UIColor.black.cgColor
        }

        setTitleColor(.white, for: .normal)

        titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 24.0)
        layer.cornerRadius = 25
        layer.borderWidth = 2
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 12.0, left: 0.0, bottom: 12.0, right: 0.0)
        translatesAutoresizingMaskIntoConstraints = false
    }

    convenience init(title: String, backgroundColor: UIColor, borderColor: UIColor, isEnabled: Bool) {
        self.init()

        setTitle(title, for: .normal)
        originalButtonText = title
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor.cgColor
        self.isEnabled = isEnabled
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Loading Animation

    private var originalButtonText: String?

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .black
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        return activityIndicator
    }()

    func loading(_ isLoading: Bool) {
        isEnabled = !isLoading
        if isLoading {
            originalButtonText = titleLabel?.text
            setTitle("", for: .normal)
            activityIndicator.startAnimating()

        } else {
            setTitle(originalButtonText, for: .normal)
            activityIndicator.stopAnimating()
        }
    }

    
}
