//
//  ViewController.swift
//  My Core Data Practice
//
//  Created by Diamonique Danner on 7/16/19.
//  Copyright © 2019 Danner Op., LLC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    @IBOutlet var newUsernameField: UITextField!
    
    @IBAction func signUp(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        let usernameText = newUsernameField.text
        
        newValue.setValue(usernameText, forKey: "username")
        
        do {
            try context.save()
            self.label.text = "Welcome \(usernameText!)!"
            
            self.newUsernameField.alpha = 0
            self.signUpButton.alpha = 0
            
        } catch {
            self.label.text = "Unable to save username, please try again"
        }
    }
    
    @IBOutlet var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        let context = appDelegate.persistentContainer.viewContext
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                if let username = result.value(forKey: "username") as? String {
                    self.label.text = "Hello \(username)"
                    
                    self.newUsernameField.alpha = 0
                    self.signUpButton.alpha = 0
                    
                } else {
                    self.label.text = "Please Sign Up"
                }
            }
        } catch {
            print("unable to retrieve usernames")
        }
        
        
        
    }


}

