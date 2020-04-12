//
//  PreLaunchViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/13/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import RevealingSplashView
import FirebaseAuth

class PreLaunchViewController: UIViewController {

    // MARK: Properties

    private let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "BuzzOnlyLogo")!, iconInitialSize: CGSize(width: 124.0, height: 124.0), backgroundColor: .techNavy)

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .techNavy
        view.addSubview(revealingSplashView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLoginStatus()
    }

    // MARK: Status Functions

    private func checkLoginStatus() {
        if AuthenticationManager().isUserSignedIn {
            let menuContainerViewController = MenuContainerViewController()
            menuContainerViewController.modalPresentationStyle = .fullScreen
            menuContainerViewController.modalTransitionStyle = .crossDissolve
            self.revealingSplashView.startAnimation({
                self.present(menuContainerViewController, animated: false, completion: nil)
            })
        } else {
            let mainSignInViewController = MainSignInViewController()
            mainSignInViewController.modalPresentationStyle = .fullScreen
            mainSignInViewController.modalTransitionStyle = .crossDissolve
            revealingSplashView.startAnimation({
                self.present(mainSignInViewController, animated: true, completion: nil)
            })
        }
    }

}
