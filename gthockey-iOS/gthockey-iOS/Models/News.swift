//
//  News.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 9/27/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class News {

    // MARK: Properties
    
    private let id: Int
    private let title: String
    private let date: Date
    private let imageURL: URL
    private let teaser: String
    private let content: String
    private var previousArticle: News?
    private var nextArticle: News?

    // MARK: Init

    init(id: Int, title: String, date: Date, imageURL: URL, teaser: String,
         content: String) {
        self.id = id
        self.title = title
        self.date = date
        self.imageURL = imageURL
        self.teaser = teaser
        self.content = content
        self.previousArticle = nil
        self.nextArticle = nil
    }

    // MARK: Getters
    
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

    func getPreviousArticle() -> News? {
        return previousArticle
    }

    func getNextArticle() -> News? {
        return nextArticle
    }

    // MARK: Setters

    func setPreviousArticle(to article: News) {
        self.previousArticle = article
    }

    func setNextArticle(to article: News) {
        self.nextArticle = article
    }
    
}
