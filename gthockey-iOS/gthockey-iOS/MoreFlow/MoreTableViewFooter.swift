//
//  MoreTableViewFooter.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 6/4/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MoreTableViewFooter: UIView {

    // MARK: Properties

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.DINCondensed.bold.font(size: 12.0)
        label.text = "Made in ATL"
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            label.text = "\(String(describing: label.text!)) | Version \(appVersion)"
        }
        
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            label.text = "\(String(describing: label.text!)) | Build \(buildNumber)"
        }

        addSubviews([label])
        updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: readableContentGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor)
        ])
    }

}
