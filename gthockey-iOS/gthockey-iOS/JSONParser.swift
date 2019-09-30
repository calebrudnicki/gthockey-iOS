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
    
    
    init(){
    }
    
    private func getArticles(completion: @escaping ([News]) -> Void){
        let articlesUrl = "https://gthockey.com/api/articles/"
        
        AF.request(articlesUrl, method: .get).validate().responseJSON { response in
               switch response.result {
               case .success(let value):
                var articles: [News] = []
                let json = JSON(value)
                for (_, json) in json {
                    articles.append(self.createArticle(data: json))
                }
                   completion(articles)
               case .failure(let error):
                   print(error)
               }
           }
    }
    
    private func createArticle(data: JSON) -> News{
        let id = data["id"].intValue
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
    
    private func getRoaster(completion: @escaping ([Player]) -> Void) {
        let roasterUrl = "https://gthockey.com/api/players/"
        
        AF.request(roasterUrl).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                var roaster: [Player] = []
                let json = JSON(value)
                for (_, player) in json {
                    roaster.append(self.createPlayer(data: player))
                }
                completion(roaster)
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
    
    private func createPlayer(data: JSON) -> Player {
        let id = data["id"].intValue
        let lastName = data["last_name"].stringValue
        let firstName = data["first_name"].stringValue
        let position = data["position"].stringValue
        let number = data["number"].intValue
        let hometown = data["hometown"].stringValue
        let major = data["school"].stringValue
        return Player(id: id, firstName: firstName, lastName: lastName, position: position, number: number, hometown: hometown, school: major)
        
    }
    
    private func getSchedule(completion: @escaping ([Game]) -> Void) {
        let scheduleUrl = "https://gthockey.com/api/games/"
        AF.request(scheduleUrl).validate().responseJSON {
            response in
            switch response.result {
            case .success(let data):
                var schedule: [Game] = []
                let json = JSON(data)
                for(_, game) in json {
                    schedule.append(self.createGame(data: game))
                }
                completion(schedule)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createGame(data: JSON) -> Game {
        let id = data["id"].intValue
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: data["date"].stringValue) ?? Date()
        
        let opponent = data["opponent_name"].stringValue
        let rink = data["rink_name"].stringValue
        let venue = data["venue"].stringValue
        let isReported = data["is_reported"].boolValue
        let shortResult = data["short_result"].stringValue
        let gtScore = data["gt_score"].int ?? nil
        let oppScore = data["opp_score"].int ?? nil
        
        return Game(id: id, dateTime: date, opponentName: opponent, rinkName: rink, venue: venue, isReported: isReported, shortResult: shortResult, gtScore: gtScore, opponentScore: oppScore)
        
    }
}
