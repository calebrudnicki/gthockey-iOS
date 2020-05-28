//
//  GTHDetailViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/26/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class GTHDetailViewController: UIViewController {

    // MARK: Properties
    
    var data: GTHCellData! {
        didSet {
            imageView.image = data.image
            primaryLabel.text = data.primaryLabel
            secondaryLabel.text = data.secondaryLabel
        }
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    public var imageView = UIImageView()
    public var primaryLabel = UILabel()
    public var secondaryLabel = UILabel()
    public var closeButton = UIButton()
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gthBackgroundColor
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        
        let backSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(close))
        backSwipe.edges = .left
        view.addGestureRecognizer(backSwipe)
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: Action
    
    @objc func imageViewTapped() {
        let fullScreenImageViewController = FullScreenImageViewController()
        fullScreenImageViewController.set(with: imageView.image ?? UIImage())
        fullScreenImageViewController.modalPresentationStyle = .overFullScreen
        present(fullScreenImageViewController, animated: false, completion: nil)
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension GTHDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let frame = imageView.convert(imageView.frame, from: view)
        if frame.minY <= -152.0 { close() }
    }
    
}
