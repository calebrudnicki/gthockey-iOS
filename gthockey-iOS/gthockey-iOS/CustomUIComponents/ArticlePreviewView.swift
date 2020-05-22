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

    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.DINCondensed.bold.font(size: 8.0)
        dateLabel.textColor = UIColor(red: 241/255, green: 242/255, blue: 235/255, alpha: 0.6)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.numberOfLines = 1
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.DINCondensed.bold.font(size: 12.0)
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let view = UIView(frame: frame)
//        let gradient = CAGradientLayer()
//        gradient.frame = frame
//        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        gradient.locations = [0.5, 1.0]
//        view.layer.insertSublayer(gradient, at: 0)
//        imageView.addSubview(view)
//        imageView.bringSubviewToFront(view)
        
        layer.applySketchShadow(color: .black, alpha: 0.5, x: 0.0, y: 16.0, blur: 16.0, spread: 0.0)
        layer.cornerRadius = 14.0
        layer.masksToBounds = true

        translatesAutoresizingMaskIntoConstraints = false

        addSubviews([imageView, dateLabel, titleLabel])
        updateConstraints()
        
//        let view = UIView(frame: frame)
//        let gradient = CAGradientLayer()
//        gradient.frame = frame
//        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        gradient.locations = [0.5, 1.0]
//        view.layer.insertSublayer(gradient, at: 0)
//        imageView.addSubview(view)
//        imageView.bringSubviewToFront(view)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.675)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            dateLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -4.0)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0)
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
        dateLabel.text = news.getDate().formatted
        titleLabel.text = news.getTitle()
        
        updateConstraints()
        
        let view = UIView(frame: frame)
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        imageView.addSubview(view)
        imageView.bringSubviewToFront(view)
    }

}
