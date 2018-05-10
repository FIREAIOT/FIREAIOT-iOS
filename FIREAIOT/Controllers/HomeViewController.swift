//
//  HomeViewController.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 02/05/2018.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import UIKit
import GoogleMaps
import RevealingSplashView

class HomeViewController: UIViewController {
    // MARK: - Properties
    private let confirmButton: Button = {
        let button = Button(title: "Send Fire Alarm", type: .primary)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSplashScreen()
        setupNavigationBar()
        setupViews()
        setupUIConstraints()
        
        view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    // MARK: - Custom UI
    fileprivate func setupViews() {
        view.addSubview(confirmButton)
    }
    
    fileprivate func setupUIConstraints() {
        _ = confirmButton.set(left: view.leftAnchor, constant: UIConstants.Edges.leadingMargin)
        _ = confirmButton.set(right: view.rightAnchor, constant: UIConstants.Edges.trailingMargin)
        _ = confirmButton.set(bottom: view.bottomAnchor, constant: -50)
        _ = confirmButton.set(height: UIConstants.Buttons.height)
    }
    
    fileprivate func showSplashScreen() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let revealingSplashView = RevealingSplashView(iconImage: #imageLiteral(resourceName: "logo"), iconInitialSize: CGSize(width: 200, height: 200), backgroundColor: .white)
        window.addSubview(revealingSplashView)
        revealingSplashView.startAnimation() { }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "FIREAIOT"
        navigationController?.navigationBar.lightContent()
        navigationController?.navigationBar.gradient(colors: [.secondary, .primary])
    }
}

