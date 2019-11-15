//
//  ApparelRestrictedItem.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 11/8/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class ApparelRestrictedItem {

    // MARK: Properties

    private var id: Int
    private var displayName: String
    private var helpText: String
    private var optionsList: [String]
    private var correspondingApparelID: Int
    private var value: String?

    // MARK: Init

    init(id: Int, displayName: String, helpText: String, optionsList: [String], correspondingApparelID: Int) {
        self.id = id
        self.displayName = displayName
        self.helpText = helpText
        self.optionsList = optionsList
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

    func getOptionsList() -> [String] {
        return optionsList
    }

    func getCorrespondingApparelID() -> Int {
        return correspondingApparelID
    }

    func getValue() -> String? {
        return value
    }

    // MARK: Setters

    func setValue(with value: String) {
        self.value = value
    }

}
