//
//  ViewController.swift
//  HighWaters
//
//  Created by Minjae Lee on 2021/11/04.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        // 위치 정확도 정도
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        
        self.locationManager.startUpdatingLocation()
        
    }
    

}

