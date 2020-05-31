//
//  GTHCardCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/27/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class GTHCardCollectionViewCell: UICollectionViewCell {

    // MARK: Properties
    
    public var imageView = UIImageView()
    public var primaryLabel = UILabel()
    public var secondaryLabel = UILabel()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

//        layer.applySketchShadow(color: .black, alpha: 0.5, x: 0.0, y: 16.0, blur: 16.0, spread: 0.0)

        contentView.layer.cornerRadius = 14.0
        contentView.layer.masksToBounds = true
    }
    
    convenience init(imageView: UIImageView, primaryLabel: UILabel, secondaryLabel: UILabel) {
        self.init()
        
        self.imageView = imageView
        self.primaryLabel = primaryLabel
        self.secondaryLabel = secondaryLabel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        contentView.layoutSubviews()
    }

    // MARK: Action
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    // MARK: Private Functions
    
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
        if isHighlighted {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: [.allowUserInteraction], animations: {
                            self.transform = .init(scaleX: 0.96, y: 0.96)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: [.allowUserInteraction], animations: {
                            self.transform = .identity
            }, completion: completion)
        }
    }
    
}
