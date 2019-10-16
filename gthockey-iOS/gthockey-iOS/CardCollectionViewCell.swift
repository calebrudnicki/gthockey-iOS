//
//  CardCollectionViewCell.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 10/16/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
           super.init(frame: frame)
           if #available(iOS 13.0, *) {
               backgroundColor = UIColor(named: "techGold")
               layer.backgroundColor = UIColor(named: "techGold")?.cgColor
               layer.shadowColor = UIColor.label.cgColor
           } else {
               layer.backgroundColor = UIColor.white.cgColor
               layer.shadowColor = UIColor.black.cgColor

           }
           layer.shadowOpacity = 0.2
           layer.shadowRadius = 7.0
           layer.cornerRadius = 6.0

           contentView.layer.cornerRadius = 6.0
           contentView.layer.masksToBounds = true


       }

       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
