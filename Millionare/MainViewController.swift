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
import FirebaseStorage

class MainViewController: UIViewController {
    
    var refUsers: DatabaseReference!
    var storageRef: StorageReference!
    var storage: Storage!
    
    @IBOutlet var userButton: UIButton!
    
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
        let cancel = UIAlertAction(title:"Cancel", style: .cancel)
        optionMenu.addAction(settings)
        optionMenu.addAction(signout)
        optionMenu.addAction(cancel)
        self.present(optionMenu, animated: true, completion: nil)
    }
    @IBOutlet var usernameTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = Storage.storage()
        storageRef = storage.reference()
        refUsers = Database.database().reference().child("user");
    }
    override func viewWillAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        let user = Auth.auth().currentUser
        let userID = user?.uid
       
        let firstname = refUsers.child(userID!).child("first_name")
        let lastname = refUsers.child(userID!).child("last_name")
        
        
        firstname.observe(.value, with : {(Snapshot) in
            if let first = Snapshot.value as? String{ self.usernameTextField.text = first + " "}})
        lastname.observe(.value, with : {(Snapshot) in
            if let last = Snapshot.value as? String{ self.usernameTextField.text?.append(last)}
            else {
                let name = Auth.auth().currentUser?.displayName
                self.usernameTextField.text = name
            }
        })
        
        //retrieve profile pic url
        refUsers.child(userID!).observe(.value, with: { (snapshot) in
            // check if user has photo
            if snapshot.hasChild("userPhoto"){
                // set image locatin
                let filePath = "\(userID!)/\("userPhoto")"
                // Assuming a < 10MB file, though you can change that
                self.storageRef.child(filePath).getData(maxSize: 10*1024*1024, completion: { (data, error) in
                    
                    let userPhoto = UIImage(data: data!)
                    self.userButton.setBackgroundImage(userPhoto, for: .normal)
                })
            }
        })
    }
    
}

