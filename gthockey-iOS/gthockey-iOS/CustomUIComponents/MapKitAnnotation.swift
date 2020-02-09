//
//  MapKitAnnotation.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 11/20/19.
//  Copyright © 2019 GT Hockey. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Contacts

class Annotation: NSObject, MKAnnotation {

    // MARK: Properties

    internal let title: String?
    internal let coordinate: CLLocationCoordinate2D

    // MARK: Init

    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate

        super.init()
    }

    // MARK: Public Functions

    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: title!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }

}