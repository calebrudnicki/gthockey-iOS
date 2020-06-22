//
//  MoreTableViewSectionHeader.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 6/10/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class MoreTableViewSectionHeader: UIView {

    // MARK: Properties
    
    public var leadingLayoutMargin: CGFloat = 24.0
    
    private let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.DINCondensed.bold.font(size: 24.0)
        title.textColor = UIColor.moreHeaderTitleColor
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.gthBackgroundColor
        addSubview(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 8.0),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingLayoutMargin),
            title.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -24.0),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0)
        ])
    }
    
    // MARK: Setter
    
    public func set(with title: String) {
        self.title.text = title
        
        updateConstraints()
    }

}
