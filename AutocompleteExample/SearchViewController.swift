//
//  SearchViewController.swift
//  AutocompleteExample
//
//  Created by George McDonnell on 26/04/2017.
//  Copyright © 2017 George McDonnell. All rights reserved.
//
//  Edited by Kaan Kabalak and Erick Lui
//
import UIKit
import MapKit

class SearchViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        searchCompleter.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // this gets printed when DescripVC loads
        let nav = segue.destination as! UINavigationController
        let descripVC = nav.topViewController as! DescriptionViewController
        descripVC.annotation = sender
    }
    
    @IBAction func unwindToSearchVC(_ segue: UIStoryboardSegue){
        let descripVC = segue.source as! DescriptionViewController
        if let a = descripVC.annotation as? MKPointAnnotation {
            a.subtitle = descripVC.descripLabel.text!
        }
        
        
    }
    
    // adding disclosure button to annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            //println("Pinview was nil")
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        button.backgroundColor = .red
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        
        let infoButton = UIButton(type: UIButtonType.detailDisclosure) as UIButton
        
        pinView?.rightCalloutAccessoryView = button
        pinView?.leftCalloutAccessoryView = infoButton
        
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control.frame.size.height == 50.0 {
            mapView.removeAnnotation(mapView.annotations[0])
        } else {
            performSegue(withIdentifier: "DescriptionSegue", sender: mapView.annotations[0])
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searching")
        map.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        map.isHidden = true
        searchCompleter.queryFragment = searchText
    }
}

extension SearchViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearchRequest(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            let country = response?.mapItems[0].placemark.country
            let name = response?.mapItems[0].name
            print("\nName: \(name!)\nCountry: \(country!)\nCoordinates: \(coordinate!)")
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate!
            self.map.addAnnotation(annotation)
            annotation.title = name
            annotation.subtitle = country
            self.map.setRegion(MKCoordinateRegionMakeWithDistance(coordinate!, 100000, 100000), animated: true)
            print("Print coords")
            self.map.isHidden = false
        }
    }
}
