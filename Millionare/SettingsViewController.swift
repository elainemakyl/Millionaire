//
//  SettingsViewController.swift
//  Millionare
//
//  Created by delta on 7/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SettingsViewController: UIViewController {
    var refUsers: DatabaseReference!

    @IBAction func changePwButton(_ sender: Any) {
        showInputDialog()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refUsers = Database.database().reference().child("user");
        // Do any additional setup after loading the view.
    }
    

        func showInputDialog() {
            //Creating UIAlertController and
            //Setting title and message for the alert dialog
            let alertController = UIAlertController(title: "change name", message: "enter a name", preferredStyle: .alert)
            
            
            //adding textfields to our dialog box
                   alertController.addTextField()
                    alertController.textFields?[0].placeholder = "First Name"
                 
                   alertController.addTextField()
                    alertController.textFields?[1].placeholder = "Last Name"
            //the confirm action taking the inputs
            let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
                
                let userid = Auth.auth().currentUser?.uid
                //getting the input values from user
                if let firstname = alertController.textFields?[0].text,
                    let lastname = alertController.textFields?[1].text {
                    self.refUsers.child(userid!).child("first_name").setValue(firstname)
                    self.refUsers.child(userid!).child("last_name").setValue(lastname)
                }
            }
            
            //the cancel action doing nothing
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
           
        
            //finally presenting the dialog box
            self.present(alertController, animated: false, completion: nil)
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
