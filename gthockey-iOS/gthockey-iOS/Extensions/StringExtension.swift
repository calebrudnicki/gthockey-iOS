//
//  StringExtension.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/25/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

extension String {

    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
}
