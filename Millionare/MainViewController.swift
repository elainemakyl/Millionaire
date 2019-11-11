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
       
    @IBAction func iconButton(_ sender: Any) {
        let optionMenu = UIAlertController(title: "Action", message: "Please select the action", preferredStyle: .actionSheet)
        let settings = UIAlertAction(title: "Settings", style: .default, handler: {(alert: UIAlertAction!) -> Void in
            //go to setting page
             self.performSegue(withIdentifier: "goToSettings", sender: nil)
        })
        let signout = UIAlertAction(title: "Sign Out", style: .default, handler: {(alert: UIAlertAction!) -> Void in
            //logout
            try! Auth.auth().signOut()
            self.performSegue(withIdentifier: "mainToLogin", sender: nil)
                   
        })
        optionMenu.addAction(settings)
        optionMenu.addAction(signout)
        self.present(optionMenu, animated: true, completion: nil)
    }
    @IBOutlet var usernameTextField: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    override func viewWillAppear(_ animated: Bool) {
         // Do any additional setup after loading the view.
               let userID = Auth.auth().currentUser?.uid
            refUsers = Database.database().reference()
       let firstname = refUsers.child("user").child(userID!).child("first_name")
        let lastname = refUsers.child("user").child(userID!).child("last_name")

              firstname.observe(.value, with : {(Snapshot) in
                      if let first = Snapshot.value as? String{ self.usernameTextField.text = first + " "}})
              lastname.observe(.value, with : {(Snapshot) in
                  if let last = Snapshot.value as? String{ self.usernameTextField.text?.append(last)}
                  else {
                    let name = Auth.auth().currentUser?.displayName
                    self.usernameTextField.text = name
                }
              })
    

                  
                   
               
                   
                  

    }

}

