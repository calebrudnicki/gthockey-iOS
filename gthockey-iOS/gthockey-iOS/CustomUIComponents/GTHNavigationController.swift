//
//  GTHNavigationController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 5/5/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import UIKit

class GTHNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.spaceCadet,
            .font: UIFont.DINCondensed.bold.font(size: 48.0)
        ]
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.spaceCadet,
            .font: UIFont.DINCondensed.bold.font(size: 24.0)
        ]
    }

}
