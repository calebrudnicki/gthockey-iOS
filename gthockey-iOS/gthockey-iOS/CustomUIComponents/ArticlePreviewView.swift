//
//  ArticlePreviewView.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 2/18/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

protocol ArticlePreviewViewDelegate {
    func previewSelected(for article: News)
}

class ArticlePreviewView: UIView {

    // MARK: Properties

    public var delegate: ArticlePreviewViewDelegate!
    private var article: News?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
            layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
            layer.shadowColor = UIColor.label.cgColor
        } else {
            layer.shadowColor = UIColor.black.cgColor
        }

        layer.shadowOpacity = 0.2
        layer.shadowRadius = 7.0
        layer.cornerRadius = 6.0

        layer.cornerRadius = 6.0
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews([imageView, titleLabel])
        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: widthAnchor)
        ])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4.0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.0)
        ])
    }

    // MARK: Action

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }, completion: nil)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { _ in
            guard let article = self.article else { return }
            self.delegate.previewSelected(for: article)
        })
    }

    // MARK: Setter

    public func set(with news: News) {
        article = news
        imageView.sd_setImage(with: news.getImageURL(), placeholderImage: nil)
        titleLabel.text = news.getTitle()
    }

}
