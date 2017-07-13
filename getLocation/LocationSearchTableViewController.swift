//
//  LocationSearchTableViewController.swift
//  getLocation
//
//  Created by Erick Lui on 7/13/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import UIKit

class LocationSearchTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension LocationSearchTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
  }
}
