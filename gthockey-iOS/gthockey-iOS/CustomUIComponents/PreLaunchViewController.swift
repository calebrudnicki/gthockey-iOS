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
        Auth.auth().signInAnonymously() { authResult, error in
            guard let user = authResult?.user else { return }
            let _ = user.isAnonymous
            let _ = user.uid

            let tabBarController = GTHTabBarController()
            tabBarController.modalPresentationStyle = .fullScreen
            tabBarController.modalTransitionStyle = .crossDissolve
            self.revealingSplashView.startAnimation({
                self.present(tabBarController, animated: false, completion: nil)
            })
        }
    }

}
