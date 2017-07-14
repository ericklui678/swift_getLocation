//
//  DescriptionViewController.swift
//  AutocompleteExample
//
//  Created by Erick Lui on 7/13/17.
//  Copyright © 2017 George McDonnell. All rights reserved.
//

import UIKit
import MapKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var descripLabel: UITextField!
    
    var annotation: Any?
    
    @IBAction func dismissButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
