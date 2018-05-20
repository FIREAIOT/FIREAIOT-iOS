//
//  HomeView.swift
//  FIREAIOT
//
//  Created by Saleem on 11/5/18.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import UIKit
import GoogleMaps

var userLocation = CLLocationCoordinate2D(latitude: -33.869405, longitude: 151.199)

protocol HomeViewDelegate {
    func sendFireButtonDidPressedWith(latitude: String, longitude: String)
}

class HomeView: BaseView {
    // MARK: - properties
    private let confirmButton: Button = {
        let button = Button(title: "Send Fire Alarm", type: .primary)
        return button
    }()
    
    private lazy var mapView: GMSMapView = {
        let defaultLocation = CLLocationCoordinate2D(latitude: -33.869405, longitude: 151.199)
        let camera = GMSCameraPosition.camera(
            withLatitude: defaultLocation.latitude,
            longitude: defaultLocation.longitude,
            zoom: zoomLevel
        )
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.settings.myLocationButton = true
        return mapView
    }()
    
    private var zoomLevel: Float = 15.0
    private var cameraCanFollowUserLocation = true
    private var locationManager = CLLocationManager()
    
    // MARK: - delegate
    var delegate: HomeViewDelegate?
    
    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLocationManager()
        perform(#selector(HomeView.setupMap), with: nil, afterDelay: 1)
        
        UIView.animate(
            withDuration: 1,
            delay: 0.4,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.2,
            options: .curveEaseInOut,
            animations: { [weak self] in
                self?.layoutIfNeeded()
            },
            completion: nil
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    override func setupTargets() {
        confirmButton.addTarget(self, action: #selector(confirmButtonDidPressed(_:)), for: .touchUpInside)
    }
    
    override func setupUI() {
        backgroundColor = .lightGray
        addSubview(confirmButton)
    }
    
    override func setupUIConstraints() {
        _ = confirmButton.set(left: leftAnchor, constant: UIConstants.Edges.leadingMargin)
        _ = confirmButton.set(right: rightAnchor, constant: UIConstants.Edges.trailingMargin)
        _ = confirmButton.set(bottom: bottomAnchor, constant: -50)
        _ = confirmButton.set(height: UIConstants.Buttons.height)
    }
    
    // MARK: - handlers
    @objc func confirmButtonDidPressed(_ sender: UIButton) {
        delegate?.sendFireButtonDidPressedWith(latitude: "\(userLocation.latitude)", longitude: "\(userLocation.longitude)")
    }
    
    // MARK: - location manager
    fileprivate func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        locationManager.delegate = self
    }
    
    // MARK: - google map
    @objc func setupMap() {
        insertSubview(mapView, belowSubview: confirmButton)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        mapView.delegate = self
        
        mapView.anchor(
            top: topAnchor,
            right: rightAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            topConstant: 0,
            rightConstant: 0,
            bottomConstant: 0,
            leftConstant: 0
        )
    }
}

// MARK: - google map delegate
extension HomeView: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        //
    }
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        //
    }
}

// MARK: - location manager delegate
extension HomeView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        userLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        guard cameraCanFollowUserLocation else { return }
        cameraCanFollowUserLocation = false
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
