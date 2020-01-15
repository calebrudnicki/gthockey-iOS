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

    public func getGame(with id: Int, completion: @escaping (Team, Rink) -> Void) {
        var opponent: Team?
        var rink: Rink?

        Alamofire.request("https://gthockey.com/api/games/\(id)").validate().responseJSON { responseData  in
            switch responseData.result {
            case .success(let value):
                let jsonResult = JSON(value)
                opponent = self.makeTeamObject(value: jsonResult["opponent"])
                rink = self.makeRinkObject(value: jsonResult["location"])
                completion(opponent!, rink!)

            case .failure(let error):
                print(error)
            }
        }
    }

    public func getShopItems(completion: @escaping ([Apparel]) -> Void) {
        var apparels: [Apparel] = []

        Alamofire.request("https://gthockey.com/api/shop/").validate().responseJSON { responseData in
            switch responseData.result {
            case .success(let value):
                let jsonResult = JSON(value)
                for (_, value) in jsonResult {
                    apparels.append(self.makeApparelObject(value: value))
                }
                completion(apparels)

            case .failure(let error):
                print(error)
            }
        }
    }

    public func getApparel(with id: Int, completion: @escaping ([ApparelRestrictedItem], [ApparelCustomItem]) -> Void) {
        var restrictedOptions: [ApparelRestrictedItem]?
        var customOptions: [ApparelCustomItem]?

        Alamofire.request("https://gthockey.com/api/shop/\(id)").validate().responseJSON { responseData in
            switch responseData.result {
            case .success(let value):
                let jsonResult = JSON(value)
                restrictedOptions = self.makeApparelRestrictedItemObject(value: jsonResult["options"])
                customOptions = self.makeApparelCustomItemObject(value: jsonResult["custom_options"])
                completion(restrictedOptions!, customOptions!)

            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: Private Functions

    private func makeNewsObject(value: JSON) -> News {
        let article = News(id: value["id"].int!,
                           title: value["title"].string!,
                           date: DateHelper().formatDate(from: value["date"].string!, withTime: false),
                           imageURL: URL(string: value["image"].string!)!,
                           teaser: value["teaser"].string!,
                           content: value["content"].string!)
        return article
    }

    private func makeGameObject(value: JSON) -> Game {
        let game = Game(id: value["id"].int!,
                        dateTime: DateHelper().formatDate(from: value["datetime"].string!, withTime: true),
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
                            imageURL: URL(string: value["image"].string ?? "https://test.gthockey.com/media/players/caleb.jpg")!,
                            headshotURL: URL(string: value["headshot"].string ?? "https://test.gthockey.com/media/players/caleb.jpg")!,
                            bio: value["bio"].string ?? "")
        return player
    }

    private func makeTeamObject(value: JSON) -> Team {
        let team = Team(id: value["id"].int!,
                        schoolName: value["school_name"].string!,
                        mascotName: value["mascot_name"].string!,
                        webURL: URL(string: value["web_url"].string ?? "http://lynnclubhockey.pointstreaksites.com/view/fightingknights/")!,
                        imageURL: URL(string: value["logo"].string ?? "https://prod.gthockey.com/media/teamlogos/EpGmgBUN_400x400.png")!)
        return team
    }

    private func makeRinkObject(value: JSON) -> Rink {
        let rink = Rink(id: value["id"].int!,
                        name: value["rink_name"].string!,
                        mapsURL: URL(string: value["maps_url"].string ?? "https://www.google.com/maps/place/Columbus+Ice+Rink/@32.4504096,-84.9886797,15z/data=!4m2!3m1!1s0x0:")!)
        return rink
    }

    private func makeApparelObject(value: JSON) -> Apparel {
        let apparel = Apparel(id: value["id"].int!,
                              name: value["name"].string!,
                              price: value["price"].double!,
                              description: value["description"].string!,
                              imageURL: URL(string: value["image"].string ?? "https://test.gthockey.com/media/players/caleb.jpg")!)
        return apparel
    }

    private func makeApparelRestrictedItemObject(value: JSON) -> [ApparelRestrictedItem] {
        var arr: [ApparelRestrictedItem] = []
        for (_, item) in value {
            let apparelRestrictedItem = ApparelRestrictedItem(id: item["id"].int!,
                                                              displayName: item["display_name"].string!,
                                                              helpText: item["help_text"].string!,
                                                              optionsList: (item["option_list"].string!).components(separatedBy: [","]),
                                                              correspondingApparelID: item["shop_item"].int!)
            arr.append(apparelRestrictedItem)
        }
        return arr
    }

    private func makeApparelCustomItemObject(value: JSON) -> [ApparelCustomItem] {
        var arr: [ApparelCustomItem] = []
        for (_, item) in value {
            let apparelCustomItem = ApparelCustomItem(id: item["id"].int!,
                                                      displayName: item["display_name"].string!,
                                                      helpText: item["help_text"].string!,
                                                      isRequired: item["required"].bool!,
                                                      extraCost: item["extra_cost"].double!,
                                                      correspondingApparelID: item["shop_item"].int!)
            arr.append(apparelCustomItem)
        }
        return arr
    }

}
