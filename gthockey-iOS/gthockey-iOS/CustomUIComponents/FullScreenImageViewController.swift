//
//  FullScreenImageViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 2/11/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class FullScreenImageViewController: UIViewController {

    // MARK: Properties

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()


    private var image = UIImage()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let closeButton = FloatingCloseButton()

    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        scrollView.delegate = self

        let doupleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageDoubleTapped(_:)))
        doupleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doupleTapGesture)
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))

        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        toolbar.setItems([shareButton], animated: true)

        scrollView.addSubview(imageView)
        view.addSubviews([scrollView, closeButton, toolbar])

        updateViewConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: toolbar.topAnchor)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12.0),
            closeButton.widthAnchor.constraint(equalToConstant: 32.0),
            closeButton.heightAnchor.constraint(equalToConstant: 32.0)
        ])

        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: Setter

    public func set(with image: UIImage) {
        imageView.image = image

        setMinZoomScaleForImageSize(image.size)
    }

    // MARK: Action

    @objc func imageDoubleTapped(_ sender: UITapGestureRecognizer) {
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            scrollView.zoom(to: zoomRectangle(scale: scrollView.maximumZoomScale, center: sender.location(in: sender.view)), animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc func shareButtonTapped() {
        let activityItem = [self.imageView.image as AnyObject]
        let activityViewController = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        self.present(activityViewController, animated: true, completion: nil)
    }

    // MARK: Helper Functions

    private func setMinZoomScaleForImageSize(_ imageSize: CGSize) {
        let widthScale = view.frame.width / imageSize.width
        let heightScale = view.frame.height / imageSize.height
        let minScale = min(widthScale, heightScale)

        // Scale the image down to fit in the view
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale

        // Set the image frame size after scaling down
        let imageWidth = imageSize.width * minScale
        let imageHeight = imageSize.height * minScale
        let newImageFrame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        imageView.frame = newImageFrame

        centerImage()
    }

    private func centerImage() {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = view.frame.size
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0

        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }

    private func zoomRectangle(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        zoomRect.origin.x = center.x - (center.x * scrollView.zoomScale)
        zoomRect.origin.y = center.y - (center.y * scrollView.zoomScale)

        return zoomRect
    }

}

extension FullScreenImageViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }

}
