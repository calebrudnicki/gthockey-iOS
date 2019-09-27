//
//  News.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 9/27/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit

class News{
    private var id: Int
    private var title: String
    private var date: Date
    private var image: UIImage
    private var content: String
    
    init(id_: Int, t: String, d: Date, img: UIImage, cont: String) {
        id = id_
        title = t
        date = d
        image = img
        content = cont
    }
    
    func get_id() -> Int{
        return id
    }
    
    func get_title() -> String{
        return title
    }
    
    func get_date() -> Date{
        return date
    }
    
    func get_image() -> UIImage{
        return image
    }
    
    func get_content() -> String{
        return content
    }
    
}
