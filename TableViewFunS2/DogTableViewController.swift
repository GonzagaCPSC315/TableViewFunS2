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


class DogTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // table view is asking its data source
        // "how many rows should I put in this section?"
        // we are only going to have one section
        if section == 0 {
            return dogs.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // table view is asking its data source
        // "what cell should I put at this indexPath?"
        // IndexPath has 2 properties
        // section number (we will ignore...)
        // row number (corresponds to array index number)
        let row = indexPath.row
        let dog = dogs[row]
        
        // we want a cell that display's this dog's name and breed
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogTableViewCell
        
        // why a reusable cell?
        // what if dogs had 10000 dogs in it?
        // we would not need 10000 cells because 10000 cells would not be in the table view at one time
        
        cell.update(with: dog)
        
        return cell
    }
    

}

