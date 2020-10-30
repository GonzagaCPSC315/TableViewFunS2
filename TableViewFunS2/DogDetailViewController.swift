//
//  DogDetailViewController.swift
//  TableViewFunS2
//
//  Created by Gina Sprint on 10/28/20.
//  Copyright © 2020 Gina Sprint. All rights reserved.
//

import UIKit

class DogDetailViewController: UIViewController {
    
    var dogOptional: Dog? = nil
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var breedTextField: UITextField!
    @IBOutlet var dogImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let dog = dogOptional {
            nameTextField.text = dog.name
            breedTextField.text = dog.breed
            dogImageView.image = UIImage(named: dog.imageName)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == "SaveUnwindSegue" {
                if let name = nameTextField.text, let breed = breedTextField.text {
                    if let dog = dogOptional {
                        dog.name = name
                        dog.breed = breed 
                    }
                    else {
                        // dog is nil...
                        // which means we got here from an AddSegue
                        dogOptional = Dog(name: name, breed: breed)
                    }
                }
            }
        }
    }
    

}
