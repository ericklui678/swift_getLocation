//
//  ViewController.swift
//  getLocation
//
//  Created by Erick Lui on 7/13/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var infoLabel: UILabel!
  
  let manager = CLLocationManager()
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // set variable to most recent location
    let location = locations[0]
    // how much we're zoomed into our current location
    let span: MKCoordinateSpan = MKCoordinateSpanMake(100, 100)
    let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
    let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
    mapView.setRegion(region, animated: true)
    
    print("Altitude: \(location.altitude), Location: \(location.speed), Coord: \(location.coordinate)")
    
    // add blue dot to current location
    self.mapView.showsUserLocation = true
    
    CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
      // if there was a problem turning coordinates into address
      if error != nil {
        print(error)
      } else {
        // place equals to most recent location
        if let place = placemark?[0] {
          if let check = place.subThoroughfare {
            self.infoLabel.text = "Country: \(place.country!) \n Thoroughfare: \(place.thoroughfare!) \n Sub: \(place.subThoroughfare!)"
          }
        }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    manager.delegate = self
    // set accuracy to best
    manager.desiredAccuracy = kCLLocationAccuracyBest
    // only get user's location when user is using app
    manager.requestWhenInUseAuthorization()
    // call function every time location is updated
    manager.startUpdatingLocation()
    
    
    let location = CLLocationCoordinate2DMake(41.878114, -87.629798)
    
    mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 1500, 1500), animated: true)
    
    let pin = PinAnnotation(title: "Chicago", subtitle: "Great City to witness", coordinate: location)
    
    mapView.addAnnotation(pin)
    
  }
    
    

    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

