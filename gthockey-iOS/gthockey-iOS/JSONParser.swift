//
//  JSONParser.swift
//  gthockey-iOS
//
//  Created by Maksim Tochilkin on 9/30/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class JSONParser {
    
    private let articlesUrl = "https://gthockey.com/api/articles/"
    private var articles: [News] = []
    
    init(){
        getArticles(url: articlesUrl)
    }
    
    private func getArticles(url: String){
        AF.request(url, method: .get).validate().responseJSON { response in
               switch response.result {
               case .success(let value):
                   let json = JSON(value)
                   for (key, json) in json {
                    self.articles.append(self.createArticle(id: key, data: json))
                    }
                   print(self.articles)
               case .failure(let error):
                   print(error)
               }
           }
    }
    
    private func createArticle(id: String, data: JSON) -> News{
        let id = Int(id)!
        let title = data["title"].stringValue
        let content = data["content"].stringValue
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: data["date"].stringValue)!
        
        let url = URL(string: data["image"].stringValue)!
        let data = try! Data(contentsOf: url)
        let image = UIImage(data: data)
        
        
        return News(id: id, title: title, date: date, image: image!, teaser: "", content: content)
        
    }
}
