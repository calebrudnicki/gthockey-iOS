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

    private let closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
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

    private let homeTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let awayTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let homeTeamMascot: UILabel = {
        let homeTeamLabel = UILabel()
        homeTeamLabel.numberOfLines = 0
        homeTeamLabel.sizeToFit()
        homeTeamLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        homeTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        return homeTeamLabel
    }()

    private let awayTeamMascot: UILabel = {
        let awayTeamLabel = UILabel()
        awayTeamLabel.numberOfLines = 0
        awayTeamLabel.sizeToFit()
        awayTeamLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        awayTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        return awayTeamLabel
    }()

    private let homeTeamTitle: UILabel = {
        let homeTeamLabel = UILabel()
        homeTeamLabel.numberOfLines = 0
        homeTeamLabel.sizeToFit()
        homeTeamLabel.font = UIFont(name: "Helvetica Neue", size: 32.0)
        homeTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        return homeTeamLabel
    }()

    private let awayTeamTitle: UILabel = {
        let awayTeamTitle = UILabel()
        awayTeamTitle.numberOfLines = 0
        awayTeamTitle.sizeToFit()
        awayTeamTitle.font = UIFont(name: "Helvetica Neue", size: 32.0)
        awayTeamTitle.translatesAutoresizingMaskIntoConstraints = false
        return awayTeamTitle
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

    private let awayTeamScore: UILabel = {
        let awayTeamScore = UILabel()
        awayTeamScore.numberOfLines = 0
        awayTeamScore.sizeToFit()
        awayTeamScore.textAlignment = .right
        awayTeamScore.font = UIFont(name: "HelveticaNeue-Light", size: 32.0)
        awayTeamScore.translatesAutoresizingMaskIntoConstraints = false
        return awayTeamScore
    }()

    private let homeTeamStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
        stackView.distribution = .fill // .fillEqually .fillProportionally .equalSpacing .equalCentering
        return stackView
    }()

    private let awayTeamStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
        stackView.distribution = .fill // .fillEqually .fillProportionally .equalSpacing .equalCentering
        return stackView
    }()

    private let homeTeamNameStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
        stackView.distribution = .fillEqually // .fillEqually .fillProportionally .equalSpacing .equalCentering
        return stackView
    }()

    private let awayTeamNameStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
        stackView.distribution = .fillEqually // .fillEqually .fillProportionally .equalSpacing .equalCentering
        return stackView
    }()

    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()

        var closeButtonImage: UIImage?

        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
            closeButtonImage = UIImage(named: "CloseButtonWhite")?.withRenderingMode(.alwaysOriginal)
        } else {
            view.backgroundColor = .white
            closeButtonImage = UIImage(named: "CloseButtonBlack")?.withRenderingMode(.alwaysOriginal)
        }

        closeButton.setImage(closeButtonImage, for: .normal)
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))

        view.addSubview(scrollView)
        scrollView.addSubviews([backgroundView, mapViewContainer, closeButton])
        backgroundView.addSubviews([homeTeamTitle, homeTeamMascot, homeTeamImageView, homeTeamScore, awayTeamTitle, awayTeamMascot, awayTeamImageView, awayTeamScore])
        
        mapViewContainer.addSubview(mapView)



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
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12.0),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            closeButton.widthAnchor.constraint(equalToConstant: 32.0),
            closeButton.heightAnchor.constraint(equalToConstant: 32.0)
        ])

        NSLayoutConstraint.activate([
            mapViewContainer.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            mapViewContainer.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            mapViewContainer.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            mapViewContainer.widthAnchor.constraint(equalTo: backgroundView.widthAnchor),
            mapViewContainer.heightAnchor.constraint(equalTo: mapViewContainer.widthAnchor, multiplier: 2/3)
        ])

        //Home Team Constraints

        NSLayoutConstraint.activate([
            homeTeamImageView.topAnchor.constraint(equalTo: mapViewContainer.bottomAnchor, constant: 8.0),
            homeTeamImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            homeTeamImageView.widthAnchor.constraint(equalToConstant: 60.0),
            homeTeamImageView.heightAnchor.constraint(equalTo: homeTeamImageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
           homeTeamMascot.topAnchor.constraint(equalTo: mapViewContainer.bottomAnchor, constant: 8.0),
           homeTeamMascot.leadingAnchor.constraint(equalTo: homeTeamImageView.trailingAnchor, constant: 12.0),
           homeTeamMascot.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            homeTeamTitle.topAnchor.constraint(equalTo: homeTeamMascot.bottomAnchor, constant: 8.0),
            homeTeamTitle.leadingAnchor.constraint(equalTo: homeTeamImageView.trailingAnchor, constant: 12.0),
            homeTeamTitle.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            homeTeamScore.topAnchor.constraint(equalTo: homeTeamMascot.bottomAnchor, constant: 8.0),
            homeTeamScore.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            homeTeamScore.heightAnchor.constraint(equalTo: homeTeamTitle.heightAnchor)
        ])

        //Away Team Constraints

        NSLayoutConstraint.activate([
            awayTeamImageView.topAnchor.constraint(equalTo: homeTeamTitle.bottomAnchor, constant: 15.0),
            awayTeamImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12.0),
            awayTeamImageView.widthAnchor.constraint(equalToConstant: 60.0),
            awayTeamImageView.heightAnchor.constraint(equalTo: awayTeamImageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            awayTeamMascot.topAnchor.constraint(equalTo: homeTeamTitle.bottomAnchor, constant: 15.0),
            awayTeamMascot.leadingAnchor.constraint(equalTo: awayTeamImageView.trailingAnchor, constant: 12.0),
            awayTeamMascot.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
           awayTeamTitle.topAnchor.constraint(equalTo: awayTeamMascot.bottomAnchor, constant: 8.0),
           awayTeamTitle.leadingAnchor.constraint(equalTo: awayTeamImageView.trailingAnchor, constant: 12.0),
           awayTeamTitle.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0)
        ])

        NSLayoutConstraint.activate([
            awayTeamScore.topAnchor.constraint(equalTo: awayTeamMascot.bottomAnchor, constant: 15.0),
            awayTeamScore.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12.0),
            awayTeamScore.heightAnchor.constraint(equalTo: homeTeamTitle.heightAnchor)
        ])
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    //MARK: MapView Functions

    private func initializeMapKitConstraints(rink: Rink){

        mapView.setRegion(MKCoordinateRegion(center: CLLocation(latitude: CLLocationDegrees(rink.getLatitude()), longitude: CLLocationDegrees(rink.getLongitude())).coordinate,
                                             latitudinalMeters: 200, longitudinalMeters: 200), animated: true)

        mapView.frame = mapViewContainer.frame

        let pin = MKPointAnnotation()
        pin.title = rink.getName()
        pin.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(rink.getLatitude()), longitude: CLLocationDegrees(rink.getLongitude()))
        mapView.addAnnotation(pin)


    }


    // MARK: Setter

    public func set(with game: Game, with opponent: Team, with rink: Rink) {
        print(game, opponent, rink)
        initializeMapKitConstraints(rink: rink)

        homeTeamImageView.image = UIImage(named: "BuzzOnlyLogo")
        awayTeamImageView.sd_setImage(with: opponent.getImageURL(), placeholderImage: nil)

        homeTeamTitle.text = "Georgia Tech"
        homeTeamMascot.text = "Yellow Jackets"
        homeTeamScore.text  = String(game.getGTScore())

        awayTeamTitle.text = opponent.getSchoolName()
        awayTeamMascot.text = opponent.getMascotName()
        awayTeamScore.text = String(game.getOpponentScore())




    }

    private func fetchGame(with id: Int, completion: @escaping (Team, Rink) -> Void) {
        let parser = JSONParser()
        parser.getGame(with: id) { (opponent, rink) in
            completion(opponent, rink)
        }


    }

    // MARK: Action

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}


