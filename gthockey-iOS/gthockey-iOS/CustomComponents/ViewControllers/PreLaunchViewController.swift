//
//  PreLaunchViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/13/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import RevealingSplashView

class PreLaunchViewController: UIViewController {

    // MARK: Properties

    private let appIconManager = AppIconManager()
    private var revealingSplashView: RevealingSplashView?
    
    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        revealingSplashView = RevealingSplashView(iconImage: UIImage(named: appIconManager.launchLogo)!,
                                                  iconInitialSize: CGSize(width: 124.0, height: 124.0),
                                                  backgroundColor: appIconManager.launchBackground)
        revealingSplashView?.alpha = 0.0
        view.addSubview(revealingSplashView!)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.revealingSplashView?.alpha = 1.0
        }, completion: { _ in
            self.checkLoginStatus()
        })
    }

    // MARK: Status Functions

    private func checkLoginStatus() {
        AuthenticationManager().signInAnonymously() { result in
            if !result { return }
            
            let tabBarController = GTHTabBarController()
            tabBarController.modalPresentationStyle = .fullScreen
            tabBarController.modalTransitionStyle = .crossDissolve
            self.revealingSplashView?.startAnimation({
                self.present(tabBarController, animated: false, completion: nil)
            })
        }
    }

}
