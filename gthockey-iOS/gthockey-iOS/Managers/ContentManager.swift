//
//  ContentManager.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 4/4/20.
//  Copyright © 2020 Caleb Rudnicki. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ContentManager {

    // MARK: Init

    init() {}

    // MARK: Public Functions

    /**
     Retrieves all articles from the GT Hockey admin page.

     - Parameter completion: The block containing an array of `News` objects to execute after the get call finishes.
     */
    public func getArticles(completion: @escaping ([News]) -> Void) {
        var articles: [News] = []

        Alamofire.request("https://gthockey.com/api/articles/").validate().responseJSON { responseData in
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

    /**
     Retrieves all rostered individuals from the GT Hockey admin page.

     - Parameter completion: The block containing an array of `Player` objects to execute after the get call finishes.
     */
    public func getRoster(completion: @escaping ([Player]) -> Void) {
        var players: [Player] = []

        Alamofire.request("https://gthockey.com/api/players/").validate().responseJSON { responseData in
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

    /**
     Retrieves all games for a particular season from the GT Hockey admin page.

     - Parameter seasonID: An optional `Int` representation for the season's unique ID value. If there is no value, the current schedule will be reached.
     - Parameter completion: The block containing an array of `Game` objects to execute after the get call finishes.
     */
    public func getSchedule(with seasonID: Int?, completion: @escaping ([Game]) -> Void) {
        var games: [Game] = []
        var endpoint = "https://gthockey.com/api/games/?fulldata"

        if let seasonID = seasonID {
            endpoint = endpoint + "&season=\(seasonID)"
        }
        
        Alamofire.request(endpoint).validate().responseJSON { responseData in
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

    /**
     Retrieves all seasons from the GT Hockey admin page.

     - Parameter completion: The block containing an array of `Season` objects to execute after the get call finishes.
     */
    public func getSeasons(completion: @escaping ([Season]) -> Void) {
        var seasons: [Season] = []

        Alamofire.request("https://gthockey.com/api/seasons/").validate().responseJSON { responseData  in
            switch responseData.result {
            case .success(let value):
                let jsonResult = JSON(value)
                for (_, value) in jsonResult {
                    seasons.append(self.makeSeasonObject(value: value))
                }
                completion(seasons)

            case .failure(let error):
                print(error)
            }
        }
    }

    /**
       Retrieves a game from the GT Hockey admin page.

       - Parameter id: An `Int` representation for the game's unique ID value
       - Parameter completion: The block containing a tuple of `(Team, Rink)` to execute after the get call finishes.
       */
    public func getGame(with id: Int, completion: @escaping (Team, Rink) -> Void) {
        var opponent: Team?
        var rink: Rink?

        Alamofire.request("https://gthockey.com/api/games/\(id)?fulldata").validate().responseJSON { responseData  in
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

    /**
     Retrieves all shop items from the GT Hockey admin page.

     - Parameter completion: The block containing an array of `Apparel` objects to execute after the get call finishes.
     */
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

    /**
       Retrieves a specific merchandise item from the GT Hockey admin page.

       - Parameter id: An `Int` representation for the merchandise's unique ID value
       - Parameter completion: The block containing a tuple of an array of `ApparelRestrictedItem` objects and
                                `ApparelCustomItem` objects to execute after the get call finishes.
       */
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
    
    /**
     Retrieves all board members from the GT Hockey admin page.

     - Parameter completion: The block containing an array of `BoardMember` objects to execute after the get call finishes.
     */
    public func getBoardMembers(completion: @escaping ([BoardMember]) -> Void) {
        var boardMembers: [BoardMember] = []

        Alamofire.request("https://gthockey.com/api/board/").validate().responseJSON { responseData  in
            switch responseData.result {
            case .success(let value):
                let jsonResult = JSON(value)
                for (_, value) in jsonResult {
                    boardMembers.append(self.makeBoardMemberObject(value: value))
                }
                completion(boardMembers)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    /**
     Retrieves all coaches from the GT Hockey admin page.

     - Parameter completion: The block containing an array of `Coach` objects to execute after the get call finishes.
     */
    public func getCoaches(completion: @escaping ([Coach]) -> Void) {
        var coaches: [Coach] = []

        Alamofire.request("https://gthockey.com/api/coaches/").validate().responseJSON { responseData  in
            switch responseData.result {
            case .success(let value):
                let jsonResult = JSON(value)
                for (_, value) in jsonResult {
                    coaches.append(self.makeCoachObject(value: value))
                }
                completion(coaches)

            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: Private Functions

    private func makeNewsObject(value: JSON) -> News {
        let article = News(id: value["id"].int!,
                           title: value["title"].string!,
                           date: value["date"].string!.shortDate,
                           imageURL: URL(string: value["image"].string!)!,
                           teaser: value["teaser"].string!,
                           content: value["content"].string!)
        return article
    }

    private func makeGameObject(value: JSON) -> Game {
        let venue: Venue
        if let venueString = value["venue"].string {
            switch venueString {
            case "H": venue = .Home
            case "A": venue = .Away
            case "T": venue = .Tournament
            default: venue = .Unknown
            }
        } else {
            venue = .Unknown
        }
        
        let result: GameResult
        if let resultString = value["short_result"].string {
            switch resultString {
            case "W": result = .Win
            case "L": result = .Loss
            case "T": result = .Tie
            case "OT": result = .OvertimeLoss
            default: result = .Unknown
            }
        } else {
            result = .Unknown
        }
                
        let game = Game(id: value["id"].int!,
                        timestamp: (value["date"].string! + " " + value["time"].string!).testDate,
                        opponent: Team(id: value["opponent"]["id"].int!,
                                       schoolName: value["opponent"]["school_name"].string!,
                                       mascotName: value["opponent"]["mascot_name"].string!,
                                       webURL: URL(string: value["opponent"]["web_url"].string!),
                                       logoImageURL: URL(string: value["opponent"]["logo"].string!)!,
                                       backgroundImageURL: (URL(string: value["opponent"]["background"].string ?? "https://prod.gthockey.com/media/teambackgrounds/ACHAZoomed.png"))!),
                        venue: venue,
                        rink: Rink(id: value["location"]["id"].int!,
                                   name: value["location"]["rink_name"].string!,
                                   mapsURL: URL(string: value["location"]["maps_url"].string!)),
                        season: Season(id: value["season"]["id"].int!,
                                       name: value["season"]["name"].string!,
                                       year: value["season"]["year"].int!),
                        gtScore: value["score_gt_final"].int,
                        opponentScore: value["score_opp_final"].int,
                        shortResult: result)
        return game
    }

    private func makeSeasonObject(value: JSON) -> Season {
        let season = Season(id: value["id"].int!,
                            name: value["name"].string!,
                            year: value["year"].int!)
        return season
    }

    private func makePlayerObject(value: JSON) -> Player {
        let position: Position
        if let positionString = value["position"].string {
            switch positionString {
            case "F": position = .Forward
            case "D": position = .Defense
            case "G": position = .Goalie
            default: position = .Manager
            }
        } else {
            position = .Manager
        }
        
        let player = Player(id: value["id"].int!,
                            firstName: value["first_name"].string!,
                            lastName: value["last_name"].string!,
                            position: position,
                            number: value["number"].int ?? 0,
                            hometown: value["hometown"].string!,
                            school: value["school"].string!,
                            imageURL: URL(string: value["image"].string ??
                                "https://test.gthockey.com/media/players/caleb.jpg")!,
                            headshotURL: URL(string: value["headshot"].string ??
                                "https://test.gthockey.com/media/players/caleb.jpg")!,
                            bio: value["bio"].string ?? "")
        return player
    }

    private func makeTeamObject(value: JSON) -> Team {
        let team = Team(id: value["id"].int!,
                        schoolName: value["school_name"].string!,
                        mascotName: value["mascot_name"].string!,
                        webURL: URL(string: value["web_url"].string!)!,
                        logoImageURL: URL(string: value["logo"].string!)!,
                        backgroundImageURL: URL(string: value["background"].string ??
                            "https://prod.gthockey.com/media/teambackgrounds/ACHAZoomed.png")!)
        return team
    }

    private func makeRinkObject(value: JSON) -> Rink {
        let rink = Rink(id: value["id"].int ?? 12345,
                        name: value["rink_name"].string ?? "TBD",
                        mapsURL: URL(string: value["maps_url"].string!))
        return rink
    }

    private func makeApparelObject(value: JSON) -> Apparel {
        let apparel = Apparel(id: value["id"].int!,
                              name: value["name"].string!,
                              price: value["price"].double!,
                              description: value["description"].string!,
                              imageURL: URL(string: value["image"].string ??
                                "https://test.gthockey.com/media/players/caleb.jpg")!)
        return apparel
    }

    private func makeApparelRestrictedItemObject(value: JSON) -> [ApparelRestrictedItem] {
        var arr: [ApparelRestrictedItem] = []
        for (_, item) in value {
            let apparelRestrictedItem = ApparelRestrictedItem(id: item["id"].int!,
                                                              displayName: item["display_name"].string!,
                                                              helpText: item["help_text"].string!,
                                                              optionsList: (item["option_list"].string!)
                                                                            .components(separatedBy: [","]),
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
    
    private func makeBoardMemberObject(value: JSON) -> BoardMember {
        let boardMember = BoardMember(id: value["id"].int!,
                                      firstName: value["first_name"].string!,
                                      lastName: value["last_name"].string!,
                                      position: value["position"].string!,
                                      email: value["email"].string!,
                                      imageURL: URL(string: value["image"].string ?? "https://test.gthockey.com/media/players/caleb.jpg")!,
                                      description: value["description"].string!)
        return boardMember
    }
    
    private func makeCoachObject(value: JSON) -> Coach {
        let coach = Coach(id: value["id"].int!,
                          firstName: value["first_name"].string!,
                          lastName: value["last_name"].string!,
                          position: value["coach_position"].string!,
                          email: value["email"].string!,
                          imageURL: URL(string: value["image"].string ?? "https://test.gthockey.com/media/players/caleb.jpg")!,
                          bio: value["bio"].string!)
        return coach
    }

}
