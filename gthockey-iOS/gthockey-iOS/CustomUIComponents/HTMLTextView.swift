//
//  HTMLTextView.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/21/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class HTMLTextView: UITextView {

    // MARK: Init

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        isScrollEnabled = false
        isEditable = false
        dataDetectorTypes = .link
        backgroundColor = .clear
        font = UIFont(name: "Georgia", size: 20.0)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setters

    public func setText(with textBody: String) {
        let contentString = textBody.replacingOccurrences(of: "\n", with: "<br>")
        let attributedString = contentString.htmlToAttributedString?.mutableCopy() as! NSMutableAttributedString
        attributedString.addAttribute(.font, value: UIFont(name: "Georgia", size: 20.0)!, range: NSRange(location: 0, length: attributedString.length))
        if #available(iOS 13.0, *) {
            attributedString.addAttribute(.foregroundColor, value: UIColor.label, range: NSRange(location: 0, length: attributedString.length))
        }
        attributedText = attributedString
    }

}
