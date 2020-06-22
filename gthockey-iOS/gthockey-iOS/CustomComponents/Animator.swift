//
//  Animator.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/23/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

enum PresentationType {
    case present
    case dismiss

    var isPresenting: Bool { return self == .present }
}

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {

    static let duration: TimeInterval = 0.5

    private let type: PresentationType
    private let fromViewController: GTHCollectionViewController
    private let toViewController: GTHDetailViewController
    private var selectedCellImageViewSnapshot: UIView

    private let cellImageViewRect: CGRect
    private let cellPrimaryRect: CGRect
    private let cellSecondaryRect: CGRect

    init?(type: PresentationType, fromViewController: GTHCollectionViewController, toViewController: GTHDetailViewController, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.fromViewController = fromViewController
        self.toViewController = toViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot

        // If guard fails, the return will trigger a standard transition
        guard let window = fromViewController.view.window ?? toViewController.view.window,
            let selectedCell = fromViewController.selectedCell
            else { return nil }

        self.cellImageViewRect = selectedCell.imageView.convert(selectedCell.imageView.bounds, to: window)
        self.cellPrimaryRect = selectedCell.primaryLabel.convert(selectedCell.primaryLabel.bounds, to: window)
        self.cellSecondaryRect = selectedCell.secondaryLabel.convert(selectedCell.secondaryLabel.bounds, to: window)
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let toView = toViewController.view else {
            transitionContext.completeTransition(false)
            return
        }

        containerView.addSubview(toView)

        guard
            let window = fromViewController.view.window ?? toViewController.view.window,
            let selectedCell = fromViewController.selectedCell,
            let cellImageSnapshot = selectedCell.imageView.snapshotView(afterScreenUpdates: true),
            let cellPrimaryLabelSnapshot = selectedCell.primaryLabel.snapshotView(afterScreenUpdates: true),
            let cellSecondaryLabelSnapshot = selectedCell.secondaryLabel.snapshotView(afterScreenUpdates: true),
            let controllerImageSnapshot = toViewController.imageView.snapshotView(afterScreenUpdates: true),
            let controllerCloseButtonSnapshot = toViewController.closeButton.snapshotView(afterScreenUpdates: true)
            else {
                transitionContext.completeTransition(true)
                return
        }

        let isPresenting = type.isPresenting
        
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = toViewController.view.backgroundColor

        if isPresenting {
            selectedCellImageViewSnapshot = cellImageSnapshot
            
            selectedCell.alpha = 0

            backgroundView = UIView(frame: containerView.bounds)
            backgroundView.addSubview(fadeView)
            fadeView.alpha = 0
        } else {
            backgroundView = fromViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
            backgroundView.addSubview(fadeView)
            selectedCell.alpha = 1
        }

        toView.alpha = 0

        containerView.addSubviews([backgroundView,
                                   selectedCellImageViewSnapshot,
                                   cellPrimaryLabelSnapshot,
                                   cellSecondaryLabelSnapshot,
                                   controllerImageSnapshot,
                                   controllerCloseButtonSnapshot
        ])

        let controllerImageViewRect = toViewController.imageView.convert(toViewController.imageView.bounds, to: window)
        let controllerPrimaryLabelRect = toViewController.primaryLabel.convert(toViewController.primaryLabel.bounds, to: window)
        let controllerSecondaryLabelRect = toViewController.secondaryLabel.convert(toViewController.secondaryLabel.bounds, to: window)
        let controllerCloseButtonRect = toViewController.closeButton.convert(toViewController.closeButton.bounds, to: window)

        [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
            $0.layer.cornerRadius = isPresenting ? 14 : 0
            $0.layer.masksToBounds = true
        }

        controllerImageSnapshot.alpha = isPresenting ? 0 : 1
        selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0

        cellPrimaryLabelSnapshot.frame = isPresenting ? cellPrimaryRect : controllerPrimaryLabelRect
        cellSecondaryLabelSnapshot.frame = isPresenting ? cellSecondaryRect : controllerSecondaryLabelRect

        controllerCloseButtonSnapshot.frame = controllerCloseButtonRect
        controllerCloseButtonSnapshot.alpha = isPresenting ? 0 : 1

        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {

                self.selectedCellImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                controllerImageSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect

                fadeView.alpha = isPresenting ? 1 : 0

                cellPrimaryLabelSnapshot.frame = isPresenting ? controllerPrimaryLabelRect : self.cellPrimaryRect
                cellSecondaryLabelSnapshot.frame = isPresenting ? controllerSecondaryLabelRect : self.cellSecondaryRect

                [controllerImageSnapshot, self.selectedCellImageViewSnapshot].forEach {
                    $0.layer.cornerRadius = isPresenting ? 0 : 14
                }
                
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                controllerImageSnapshot.alpha = isPresenting ? 1 : 0
            }

            UIView.addKeyframe(withRelativeStartTime: isPresenting ? 0.7 : 0, relativeDuration: 0.3) {
                controllerCloseButtonSnapshot.alpha = isPresenting ? 1 : 0
            }
            
        }, completion: { _ in
            self.selectedCellImageViewSnapshot.removeFromSuperview()
            controllerImageSnapshot.removeFromSuperview()
            backgroundView.removeFromSuperview()
            cellPrimaryLabelSnapshot.removeFromSuperview()
            cellSecondaryLabelSnapshot.removeFromSuperview()
            controllerCloseButtonSnapshot.removeFromSuperview()

            toView.alpha = 1

            transitionContext.completeTransition(true)
        })
    }
}
