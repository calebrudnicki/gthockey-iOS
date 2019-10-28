//
//  Player.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 9/27/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class Player {

    // MARK: Properties

    private var id: Int
    private var firstName: String
    private var lastName: String
    private var position: String
    private var number: Int
    private var hometown: String
    private var school: String
    private var imageURL: URL
    private var headshotURL: URL
    private var bio: String

    // MARK: Init

    init(id: Int, firstName: String, lastName: String, position: String, number: Int,
         hometown: String, school: String, imageURL: URL, headshotURL: URL, bio: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.number = number
        self.hometown = hometown
        self.school = school
        self.imageURL = imageURL
        self.headshotURL = headshotURL
        self.bio = bio
    }

    // MARK: Getters

    func getID() -> Int {
        return id
    }

    func getFirstName() -> String {
        return firstName
    }

    func getLastName() -> String {
        return lastName
    }

    func getPosition() -> String {
        return position
    }

    func getPositionLong() -> String {
        switch position {
        case "F":
            return "Forward"
        case "D":
            return "Defense"
        case "G":
            return "Goalie"
        default:
            return "Manager"
        }
    }

    func getNumber() -> Int {
        return number
    }

    func getHometown() -> String {
        return hometown
    }

    func getSchool() -> String {
        return school
    }

    func getImageURL() -> URL {
        return imageURL
    }

    func getHeadshotURL() -> URL {
        return headshotURL
    }

    func getBio() -> String {
        return bio
    }

}
