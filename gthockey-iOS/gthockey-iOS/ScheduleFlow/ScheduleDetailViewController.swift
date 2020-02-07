//
//  ScheduleDetailViewController.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 11/19/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit
import SDWebImage
import MapKit

class ScheduleDetailViewController: UIViewController {

    // MARK: Properties

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        return mapView
    }()

    private let mapViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let closeButton = FloatingCloseButton()

    private let gameTypeLabel: UILabel = {
        let gameTypeLabel = UILabel()
        gameTypeLabel.numberOfLines = 0
        gameTypeLabel.sizeToFit()
        gameTypeLabel.textColor = .techGold
        gameTypeLabel.textAlignment = .center
        gameTypeLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        gameTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        return gameTypeLabel
    }()

    private let awayTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let awayTeamStackView: UIStackView = {
        let awayTeamStackView = UIStackView()
        awayTeamStackView.axis = .vertical
        awayTeamStackView.distribution = .fillProportionally
        awayTeamStackView.spacing = 4.0
        awayTeamStackView.translatesAutoresizingMaskIntoConstraints = false
        return awayTeamStackView
    }()

    private let awayTeamMascot: UILabel = {
        let awayTeamLabel = UILabel()
        awayTeamLabel.numberOfLines = 0
        awayTeamLabel.sizeToFit()
        awayTeamLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        awayTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        return awayTeamLabel
    }()

    private let awayTeamTitle: UILabel = {
        let awayTeamTitle = UILabel()
        awayTeamTitle.numberOfLines = 0
        awayTeamTitle.sizeToFit()
        awayTeamTitle.font = UIFont(name: "Helvetica Neue", size: 32.0)
        awayTeamTitle.translatesAutoresizingMaskIntoConstraints = false
        return awayTeamTitle
    }()

    private let awayTeamScore: UILabel = {
        let awayTeamScore = UILabel()
        awayTeamScore.numberOfLines = 0
        awayTeamScore.sizeToFit()
        awayTeamScore.textAlignment = .right
        awayTeamScore.font = UIFont(name: "HelveticaNeue-Light", size: 32.0)
        awayTeamScore.translatesAutoresizingMaskIntoConstraints = false
        return awayTeamScore
    }()

    private let homeTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let homeTeamStackView: UIStackView = {
        let homeTeamStackView = UIStackView()
        homeTeamStackView.axis = .vertical
        homeTeamStackView.distribution = .fillProportionally
        homeTeamStackView.spacing = 4.0
        homeTeamStackView.translatesAutoresizingMaskIntoConstraints = false
        return homeTeamStackView
    }()

    private let homeTeamMascot: UILabel = {
        let homeTeamLabel = UILabel()
        homeTeamLabel.numberOfLines = 0
        homeTeamLabel.sizeToFit()
        homeTeamLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        homeTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        return homeTeamLabel
    }()

    private let homeTeamTitle: UILabel = {
        let homeTeamLabel = UILabel()
        homeTeamLabel.numberOfLines = 0
        homeTeamLabel.sizeToFit()
        homeTeamLabel.font = UIFont(name: "Helvetica Neue", size: 32.0)
        homeTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        return homeTeamLabel
    }()

    private let homeTeamScore: UILabel = {
        let homeTeamScore = UILabel()
        homeTeamScore.numberOfLines = 0
        homeTeamScore.sizeToFit()
        homeTeamScore.textAlignment = .center
        homeTeamScore.font = UIFont(name: "HelveticaNeue-Light", size: 32.0)
        homeTeamScore.translatesAutoresizingMaskIntoConstraints = false
        return homeTeamScore
    }()

    private let resultStackView: UIStackView = {
        let resultStackView = UIStackView()
        resultStackView.axis = .vertical
        resultStackView.distribution = .fillProportionally
        resultStackView.spacing = 4.0
        resultStackView.translatesAutoresizingMaskIntoConstraints = false
        return resultStackView
    }()

    private let resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.numberOfLines = 0
        resultLabel.sizeToFit()
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()

    private let scheduleDateTimeView = ScheduleDateTimeView()

    private let rinkLabel: UILabel = {
        let rinkLabel = UILabel()
        rinkLabel.numberOfLines = 0
        rinkLabel.sizeToFit()
        rinkLabel.textAlignment = .center
        rinkLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        rinkLabel.translatesAutoresizingMaskIntoConstraints = false
        return rinkLabel
    }()

    private let getDirectionsButton = PillButton(title: "Get directions", backgroundColor: .techNavy, borderColor: .techNavy, isEnabled: true)

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        mapView.delegate = self

        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))
        getDirectionsButton.addTarget(self, action: #selector(getDirectionsButtonTapped), for: .touchUpInside)

        view.addSubview(scrollView)
        mapViewContainer.addSubview(mapView)
        scrollView.addSubviews([backgroundView, mapViewContainer, closeButton, getDirectionsButton])

        awayTeamStackView.addArrangedSubview(awayTeamMascot)
        awayTeamStackView.addArrangedSubview(awayTeamTitle)

        homeTeamStackView.addArrangedSubview(homeTeamMascot)
        homeTeamStackView.addArrangedSubview(homeTeamTitle)

        resultStackView.addArrangedSubview(resultLabel)
        resultStackView.addArrangedSubview(scheduleDateTimeView)
        resultStackView.addArrangedSubview(rinkLabel)

        backgroundView.addSubviews([gameTypeLabel, awayTeamImageView, awayTeamStackView, awayTeamScore,
                                    homeTeamStackView, homeTeamImageView, homeTeamScore, resultStackView])
        updateViewConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            mapViewContainer.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            mapViewContainer.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            mapViewContainer.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            mapViewContainer.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
            closeButton.widthAnchor.constraint(equalToConstant: 32.0),
            closeButton.heightAnchor.constraint(equalToConstant: 32.0)
        ])

        NSLayoutConstraint.activate([
            gameTypeLabel.topAnchor.constraint(equalTo: mapViewContainer.bottomAnchor, constant: 8.0),
            gameTypeLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            gameTypeLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            awayTeamImageView.topAnchor.constraint(equalTo: gameTypeLabel.bottomAnchor, constant: 16.0),
            awayTeamImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            awayTeamImageView.widthAnchor.constraint(equalToConstant: 60.0),
            awayTeamImageView.heightAnchor.constraint(equalTo: awayTeamImageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            awayTeamStackView.topAnchor.constraint(equalTo: awayTeamImageView.topAnchor),
            awayTeamStackView.leadingAnchor.constraint(equalTo: awayTeamImageView.trailingAnchor, constant: 12.0),
            awayTeamStackView.trailingAnchor.constraint(equalTo: awayTeamScore.trailingAnchor, constant: -12.0),
            awayTeamStackView.bottomAnchor.constraint(equalTo: awayTeamImageView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            awayTeamScore.topAnchor.constraint(equalTo: awayTeamImageView.topAnchor),
            awayTeamScore.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            awayTeamScore.bottomAnchor.constraint(equalTo: awayTeamImageView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            homeTeamImageView.topAnchor.constraint(equalTo: awayTeamImageView.bottomAnchor, constant: 16.0),
            homeTeamImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            homeTeamImageView.widthAnchor.constraint(equalToConstant: 60.0),
            homeTeamImageView.heightAnchor.constraint(equalTo: homeTeamImageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            homeTeamStackView.topAnchor.constraint(equalTo: homeTeamImageView.topAnchor),
            homeTeamStackView.leadingAnchor.constraint(equalTo: homeTeamImageView.trailingAnchor, constant: 12.0),
            homeTeamStackView.trailingAnchor.constraint(equalTo: homeTeamScore.trailingAnchor, constant: -12.0),
            homeTeamStackView.bottomAnchor.constraint(equalTo: homeTeamImageView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            homeTeamScore.topAnchor.constraint(equalTo: homeTeamImageView.topAnchor),
            homeTeamScore.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            homeTeamScore.bottomAnchor.constraint(equalTo: homeTeamImageView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            resultStackView.topAnchor.constraint(equalTo: homeTeamStackView.bottomAnchor, constant: 16.0),
            resultStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            resultStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            getDirectionsButton.topAnchor.constraint(equalTo: resultStackView.bottomAnchor, constant: 16.0),
            getDirectionsButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            getDirectionsButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])
    }

    private func setupMapKitConstraints(with rink: Rink) {
        mapView.setRegion(MKCoordinateRegion(center: CLLocation(latitude: CLLocationDegrees(rink.getLatitude()), longitude: CLLocationDegrees(rink.getLongitude())).coordinate,
                                             latitudinalMeters: 300, longitudinalMeters: 300), animated: true)
        mapView.frame = mapViewContainer.frame
        let annotation = Annotation(title: rink.getName(),
                                    coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(rink.getLatitude()), longitude: CLLocationDegrees(rink.getLongitude())))
        mapView.addAnnotation(annotation)
    }

    // MARK: Setter

    public func set(with game: Game, _ opponent: Team, _ rink: Rink) {
        if game.getVenue() == .Home {
            awayTeamTitle.text = opponent.getSchoolName()
            awayTeamMascot.text = opponent.getMascotName()
            awayTeamScore.text  = game.getIsReported() ? String(game.getOpponentScore()) : nil
            awayTeamImageView.sd_setImage(with: opponent.getImageURL(), placeholderImage: nil)

            homeTeamTitle.text = "Georgia Tech"
            homeTeamMascot.text = "Yellow Jackets"
            homeTeamScore.text  = game.getIsReported() ? String(game.getGTScore()) : nil
            homeTeamImageView.image = UIImage(named: "BuzzOnlyLogo")
        } else {
            awayTeamTitle.text = "Georgia Tech"
            awayTeamMascot.text = "Yellow Jackets"
            awayTeamScore.text  = game.getIsReported() ? String(game.getGTScore()) : nil
            awayTeamImageView.image = UIImage(named: "BuzzOnlyLogo")

            homeTeamTitle.text = opponent.getSchoolName()
            homeTeamMascot.text = opponent.getMascotName()
            homeTeamScore.text  = game.getIsReported() ? String(game.getOpponentScore()) : nil
            homeTeamImageView.sd_setImage(with: opponent.getImageURL(), placeholderImage: nil)
        }

        if game.getIsReported() {
            switch game.getShortResult() {
            case "W":
                resultLabel.text = "Win"
                resultLabel.textColor = .winGreen
            case "L":
                resultLabel.text = "Loss"
                resultLabel.textColor = .lossRed
            default:
                resultLabel.text = "OT"
                resultLabel.textColor = .lossRed
            }
        } else {
            resultLabel.text = "Game Upcoming"
            resultLabel.textColor = .gray
        }

        scheduleDateTimeView.set(with: game.getDateTime())
        rinkLabel.text = rink.getName()

        gameTypeLabel.text = game.getVenue().description

        setupMapKitConstraints(with: rink)
    }

    // MARK: Actions

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func getDirectionsButtonTapped() {
        openInMaps(with: mapView.annotations[0] as! Annotation)
    }

    private func openInMaps(with location: Annotation) {
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }

}

extension ScheduleDetailViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Annotation else { return nil }

        let identifier = "marker"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
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
        openInMaps(with: view.annotation as! Annotation)
    }
    
}
