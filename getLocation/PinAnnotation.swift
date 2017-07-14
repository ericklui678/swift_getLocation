//
//  PinAnnotation.swift
//  getLocation
//
//  Created by rukang fan on 7/13/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import MapKit

class PinAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D){
        
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
