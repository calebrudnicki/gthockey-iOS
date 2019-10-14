//
//  JSONParser.swift
//  GTHockey
//
//  Created by Dylan Mace on 9/29/19.
//  Copyright © 2019 Dylan Mace. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class JSONParser {

    init() {}

    // MARK: Public Functions

    public func getArticles(completion: @escaping ([News]) -> Void) {
        var articles: [News] = []

        Alamofire.request("https://gthockey.com/api/articles/").validate().responseJSON { responseData  in
            switch responseData.result {
            case .success(let value):
                let jsonResult = JSON(value)
                for (_, value) in jsonResult {
                    articles.append(self.makeNewsObject(value: value))
                }
                completion(articles)

            case .failure(let error):
                print(error)
            }
        }
    }

    public func getRoster(completion: @escaping ([Player]) -> Void) {
        var players: [Player] = []

        Alamofire.request("https://gthockey.com/api/players/").validate().responseJSON { responseData  in
            switch responseData.result {
            case .success(let value):
                let jsonResult = JSON(value)
                for (_, value) in jsonResult {
                    players.append(self.makePlayerObject(value: value))
                }
                completion(players)

            case .failure(let error):
                print(error)
            }
        }
    }

    public func getSchedule(completion: @escaping ([Game]) -> Void) {
        var games: [Game] = []

        Alamofire.request("https://gthockey.com/api/games/").validate().responseJSON { responseData  in
            switch responseData.result {
            case .success(let value):
                let jsonResult = JSON(value)
                for (_, value) in jsonResult {
                    games.append(self.makeGameObject(value: value))
                }
                completion(games)

            case .failure(let error):
                print(error)
            }
        }
    }

    public func getGame(with id: Int, completion: @escaping (Rink) -> Void) {
        var rink: Rink?

        Alamofire.request("https://gthockey.com/api/games/\(id)").validate().responseJSON { responseData  in
            switch responseData.result {
            case .success(let value):
                let jsonResult = JSON(value)
                rink = self.makeRinkObject(value: jsonResult["location"])
                completion(rink!)

            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: Private Functions

    private func makeNewsObject(value: JSON) -> News {
        let article = News(id: value["id"].int!,
                           title: value["title"].string!,
                           date: formatDate(from: value["date"].string!, withTime: false),
                           imageURL: URL(string: value["image"].string!)!,
                           teaser: value["teaser"].string!,
                           content: value["content"].string!)
        return article
    }

    private func makeGameObject(value: JSON) -> Game {
        let game = Game(id: value["id"].int!,
                        dateTime: formatDate(from: value["datetime"].string!, withTime: true),
                        opponentName: value["opponent_name"].string!,
                        rinkName: value["rink_name"].string!,
                        venue: value["venue"].string!,
                        isReported: value["is_reported"].bool!,
                        shortResult: value["short_result"].string!,
                        gtScore: value["gt_score"].int ?? 0,
                        opponentScore: value["opp_score"].int ?? 0)
        return game
    }

    private func makePlayerObject(value: JSON) -> Player {
        let player = Player(id: value["id"].int!,
                            firstName: value["first_name"].string!,
                            lastName: value["last_name"].string!,
                            position: value["position"].string!,
                            number: value["number"].int ?? 0,
                            hometown: value["hometown"].string!,
                            school: value["school"].string!,
                            imageURL: URL(string: value["image"].string ?? "https://test.gthockey.com/media/players/caleb.jpg")!)
        return player
    }

    private func makeRinkObject(value: JSON) -> Rink {
        let rink = Rink(id: value["id"].int!,
                        name: value["rink_name"].string!,
                        mapsURL: URL(string: value["maps_url"].string! ?? "https://www.google.com/maps/place/Columbus+Ice+Rink/@32.4504096,-84.9886797,15z/data=!4m2!3m1!1s0x0:")!)
        return rink
    }

    private func formatDate(from dateString: String, withTime: Bool) -> Date {
        let formatter = DateFormatter()
        if withTime {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        } else {
            formatter.dateFormat = "yyyy-MM-dd"
        }
        return formatter.date(from: dateString)!
    }

}
