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
    
    // MARK: Lab #19.a.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let dog = dogs.remove(at: sourceIndexPath.row)
        dogs.insert(dog, at: destinationIndexPath.row)
        // MARK: Lab #19.b.
        tableView.reloadData()
    }
    
    // MARK: Lab #20
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // GS: adding this for Lab #20 solution
        if editingStyle == .delete {
            dogs.remove(at: indexPath.row)
            // MARK: Lab #20.a.
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "DetailSegue" {
                if let dogDetailVC = segue.destination as? DogDetailViewController {
                    if let indexPath = tableView.indexPathForSelectedRow {
                        let dog = dogs[indexPath.row]
                        dogDetailVC.dogOptional = dog 
                    }
                }
            }
            else if identifier == "AddSegue" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    // delect the row!!
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            }
        }
    }
    
    @IBAction func unwindToDogTableViewController(segue: UIStoryboardSegue) {
        // grab the updated dog from the source VC (DogDetailViewController)
        if let identifier = segue.identifier {
            if identifier == "SaveUnwindSegue" {
                if let dogDetailVC = segue.source as? DogDetailViewController {
                    if let dog = dogDetailVC.dogOptional {
                        if let indexPath = tableView.indexPathForSelectedRow {
                            dogs[indexPath.row] = dog
                        }
                        else {
                            // there is no selected row
                            // -> unwinding from an AddSegue
                            dogs.append(dog)
                        }
                        // force refresh
                        tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        let newEditingMode = !tableView.isEditing
        tableView.setEditing(newEditingMode, animated: true)
    }

}

