//
//  ViewController.swift
//  HighWaters
//
//  Created by Minjae Lee on 2021/11/04.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    private var rootRef: DatabaseReference!

    
    private var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Access rootRef
        self.rootRef = Database.database().reference()
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        // 위치 정확도 정도
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        
        self.locationManager.startUpdatingLocation()
        
        setupUI()
    }
    
    private func setupUI() {
        
        let addFloodButton = UIButton(frame: CGRect.zero)
        addFloodButton.setImage(UIImage(named: "plus-image"), for: .normal)
        
        addFloodButton.addTarget(self, action: #selector(addFloodAnnotationButtonPressed), for: .touchUpInside)
        addFloodButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(addFloodButton)
        
        addFloodButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addFloodButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        addFloodButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        addFloodButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    @objc func addFloodAnnotationButtonPressed(sender :Any?) {
        if let location = self.locationManager.location {
            let floodAnnotation = MKPointAnnotation()
            floodAnnotation.coordinate = location.coordinate
            self.mapView.addAnnotation(floodAnnotation)
            
            let coordinate = location.coordinate
            let flood = Flood(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
            // Child Reference
            let floodedRegionRef = self.rootRef.child("flooded-regions")
            let floodRef = floodedRegionRef.child("flood")
            floodRef.setValue(flood.toDictionary())
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Zooming
        if let location = locations.first {
            let coordinate = location.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
        }
    }
    

}

