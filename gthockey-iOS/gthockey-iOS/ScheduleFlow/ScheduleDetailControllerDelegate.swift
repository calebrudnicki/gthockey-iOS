//
//  ScheduleDetailControllerDelegate.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 11/20/19.
//  Copyright © 2019 GT Hockey. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Contacts


extension ScheduleDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Annotation else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        }

        else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true

            let button = UIButton(type: .detailDisclosure)
            var carImage: UIImage
            if #available(iOS 13.0, *) {
                carImage = UIImage(systemName: "car")!
                button.setImage(carImage, for: .normal)
            }
            view.rightCalloutAccessoryView = button

        }

        return view
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Annotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
