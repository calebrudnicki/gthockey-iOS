//
//  ApparelCustomItem.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/8/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class ApparelCustomItem {

    // MARK: Properties

    private var id: Int
    private var displayName: String
    private var helpText: String
    private var isRequired: Bool
    private var extraCost: Int
    private var correspondingApparelID: Int

    // MARK: Init

    init(id: Int, displayName: String, helpText: String, isRequired: Bool, extraCost: Int, correspondingApparelID: Int) {
        self.id = id
        self.displayName = displayName
        self.helpText = helpText
        self.isRequired = isRequired
        self.extraCost = extraCost
        self.correspondingApparelID = correspondingApparelID
    }

    // MARK: Getters

    func getID() -> Int {
        return id
    }

    func getDisplayName() -> String {
        return displayName
    }

    func getHelpText() -> String {
        return helpText
    }

    func getIsRequired() -> Bool {
        return isRequired
    }

    func getExtraCost() -> Int {
        return extraCost
    }

    func getCorrespondingApparelID() -> Int {
        return correspondingApparelID
    }

}