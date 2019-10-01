//
//  News.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 9/27/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class News {
    
    private let id: Int
    private let title: String
    private let date: Date
    private let imageURL: URL
    private let teaser: String
    private let content: String

    init(id: Int, title: String, date: Date, imageURL: URL, teaser: String, content: String) {
        self.id = id
        self.title = title
        self.date = date
        self.imageURL = imageURL
        self.teaser = teaser
        self.content = content
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

    func getImageURL() -> URL {
        return imageURL
    }
    
    func getContent() -> String {
        return content
    }
    
}
