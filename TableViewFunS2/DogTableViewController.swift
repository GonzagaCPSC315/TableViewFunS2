//
//  ViewController.swift
//  TableViewFunS2
//
//  Created by Gina Sprint on 10/21/20.
//  Copyright © 2020 Gina Sprint. All rights reserved.
//

import UIKit

// MARK: - Table Views
// a table view is a list of cells
// 2 ways to set up a view controller with a table view
// 1. "manual": add a table view to our scene, then register VC as the data source and the delegate for our table view
// 2. use a UITableViewController which abstracts alot of the management for us
// the rootview is the table view (you can't add additional views to your scene)
// we will use #1 because ADS uses #2


class DogTableViewController: UIViewController {
    
    var dogs = [Dog]()
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeDogs()
    }

    func initializeDogs() {
        dogs.append(Dog(name: "Lassie", breed: "Collie"))
        dogs.append(Dog(name: "AirBud", breed: "Retriever"))
        dogs.append(Dog(name: "Spike", breed: "Bulldog"))
    }

}

