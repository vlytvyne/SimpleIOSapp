//
//  FirstViewController.swift
//  IntroductioniOS
//
//  Created by Nadiia KUCHYNA on 11/30/18.
//  Copyright © 2018 nkuchyna. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
        if  Data.places.count >= pinCode - 1{
            centerMapOnLocation(coordinates: CLLocationCoordinate2DMake(Data.places[pinCode].2, Data.places[pinCode].3), regionRadius: 500)
        }
    }
    var pinCode: Int!
    
    //selecting mode of map
    @IBAction func controlBar(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    @IBAction func buttomGeoLocation(_ sender: UIButton) {
        guard let locValue: CLLocationCoordinate2D = localManager.location?.coordinate else { return }
        centerMapOnLocation(coordinates: locValue, regionRadius: 200)
    }
    
    @IBOutlet weak var mapView: MKMapView!
    var localManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //request for accessing user location
        localManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            localManager.delegate = self
            localManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            localManager.distanceFilter = 10
            localManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
        }
        if (Data.places.count == 0){
            return;
        }

        //default location initialisation
        let defLocation = CLLocation(latitude: Data.places[0].2, longitude: Data.places[0].3)
        centerMapOnLocation(coordinates: defLocation.coordinate, regionRadius: 500)
        for i in 0...(Data.places.count - 1) {
             addAnnotation(title:  Data.places[i].0, subtitle:  Data.places[i].1, annotLatitude: Data.places[i].2, annotLongitude: Data.places[i].3)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated!")
    }

    func centerMapOnLocation(coordinates: CLLocationCoordinate2D, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinates, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addAnnotation(title: String, subtitle: String, annotLatitude: Double, annotLongitude: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: annotLatitude, longitude: annotLongitude)
        annotation.title = title
        annotation.subtitle = subtitle
        self.mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let annotationView = MKPinAnnotationView()
        if (annotation.title! == "Ecole 42" || annotation.title! == "UNIT Factory" ){
            annotationView.pinTintColor = UIColor.green
        } else {
            annotationView.pinTintColor = UIColor.red
        }
        annotationView.canShowCallout = true
        return annotationView
    }
    
}
