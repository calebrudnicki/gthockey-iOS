//
//  Rink.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 10/14/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class Rink {

    // MARK: Properties

    private var id: Int
    private var name: String
    private var mapsURL: URL
    private var longitude: Float
    private var latitude: Float

    // MARK: Init

    init(id: Int, name: String, mapsURL: URL) {
        self.id = id
        self.name = name
        self.mapsURL = mapsURL
        self.longitude = 0
        self.latitude = 0

        findLocation(from: mapsURL)
    }

    // MARK: Getters

    func getID() -> Int {
        return id
    }

    func getName() -> String {
        return name
    }

    func getMapsURL() -> URL {
        return mapsURL
    }

    func getLatitude() -> Float {
        return latitude
    }

    func getLongitude() -> Float {
        return longitude
    }

    // MARK: Helper Functions

    private func findLocation(from url: URL) {
        if let latitudeString = url.absoluteString.slice(from: "@", to: ",") {
            self.latitude = Float(latitudeString)!
        }

        if let longitudeString = url.absoluteString.slice(from: ",", to: ",") {
            self.longitude = Float(longitudeString)!
        }
    }

}
