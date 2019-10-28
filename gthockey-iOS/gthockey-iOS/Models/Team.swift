//
//  Team.swift
//  gthockey-iOS
//
//  Created by Maksim Tochilkin on 10/8/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class Team {

    // MARK: Properties

    private var id: Int
    private var schoolName: String
    private var mascotName: String
    private var webURL: URL
    private var imageURL: URL

    // MARK: Init

    init(id: Int, schoolName: String, mascotName: String, webURL: URL, imageURL: URL) {
        self.id = id
        self.schoolName = schoolName
        self.mascotName = mascotName
        self.webURL = webURL
        self.imageURL = imageURL
    }

    // MARK: Getters

    func getID() -> Int {
        return self.id
    }

    func getSchoolName() -> String {
        return self.schoolName
    }

    func getMascotName() -> String {
        return self.mascotName
    }

    func getWebURL() -> URL {
        return self.webURL
    }

    func getImageURL() -> URL {
        return self.imageURL
    }
    
}
