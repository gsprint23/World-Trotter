//
//  MapViewController.swift
//  World Trotter
//
//  Created by Gina Sprint on 6/18/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()
    
    var isZoomedUserLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello from MapViewController.viewDidLoad()")
        // https://swiftludus.org/how-to-access-the-users-location-in-ios-apps/
//        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation()
    }
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        
        // set it as the view of this view controller
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        let zoomButton = UIButton(type: .roundedRect)
        zoomButton.setTitle("Zoom", for: .normal)
        //zoomButton.backgroundColor = segmentedControl.tintColor
        zoomButton.addTarget(self, action: #selector(MapViewController.zoomToUserLocation(_:)), for: .touchUpInside)
        zoomButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(zoomButton)

        let bottomConstraintButton = zoomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        let leadingConstraintButton = zoomButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraintButton = zoomButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        bottomConstraintButton.isActive = true
        leadingConstraintButton.isActive = true
        trailingConstraintButton.isActive = true
    }
    
    @objc func zoomToUserLocation(_ sender: UIButton) {
        print("zoom!")
        mapView.userTrackingMode = .followWithHeading
    }
    
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        print("in mapView(didUpdate userLocation")
//        if !isZoomedUserLocation {
//            isZoomedUserLocation = true
//            mapView.showAnnotations([userLocation], animated: true)
//        }
//    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
}
