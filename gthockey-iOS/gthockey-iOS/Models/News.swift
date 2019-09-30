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
    private var teaser: String
    private var date: Date
    private var image: UIImage
    private var content: String
    
    init(id: Int, title: String, date: Date, image: UIImage, teaser: String, content: String) {
        self.id = id
        self.title = title
        self.date = date
        self.image = image
        self.content = content
        self.teaser = teaser
    }
    
    func getID() -> Int {
        return id
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getTeaser() -> String {
        return teaser
    }
    
    func getDate() -> Date {
        return date
    }
    
    func getImage() -> UIImage {
        return image
    }
    
    func getContent() -> String {
        return content
    }
    
}
