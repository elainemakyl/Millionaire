//
//  FirstViewController.swift
//  Millionare
//
//  Created by delta on 5/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController {

    
    var refUsers: DatabaseReference!
       
    @IBOutlet var usernameTextField: UILabel!
    @IBAction func signoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
         self.performSegue(withIdentifier: "mainToLogin", sender: nil)
        
            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let userID = Auth.auth().currentUser?.uid
        if let name = Auth.auth().currentUser?.displayName {
            usernameTextField.text = name
        } else {
           
            refUsers = Database.database().reference()
        
            let firstname = refUsers.child("user").child(userID!).child("first_name")
            let lastname = refUsers.child("user").child(userID!).child("last_name")

            firstname.observeSingleEvent(of : .value, with : {(Snapshot) in
                    if let first = Snapshot.value as? String{ self.usernameTextField.text = first + " "}})
            lastname.observeSingleEvent(of : .value, with : {(Snapshot) in
                if let last = Snapshot.value as? String{ self.usernameTextField.text?.append(last)}})
          
            
           
        }
            
    }


}

