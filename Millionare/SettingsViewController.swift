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
    
    @IBAction func changeNameButton(_ sender: Any) {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Change name", message: "Enter a new name", preferredStyle: .alert)
        
        
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
    
    
    @IBAction func changePwButton(_ sender: Any) {
        //check if log in by email provider
        let user = Auth.auth().currentUser
        let providerID = user?.providerID
        var message : String = ""
        
        
        
        
        switch (providerID){
        case("facebook.com"):
            message = "Password cannot be changed because you sign in with Facebook account!"
            displayErrorMessage(message: message)
        case("google.com"):
            message = "Password cannot be change because you signed in with Google account!"
            displayErrorMessage(message: message)
        default:
            message = "Please enter your current password"
            let alertController = UIAlertController(title: "Authorization", message: message, preferredStyle: .alert)
            alertController.addTextField()
            alertController.textFields?[0].placeholder = "Password"
            alertController.textFields?[0].isSecureTextEntry = true
            
            let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
                let credential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: (alertController.textFields?[0].text)!)
                user?.reauthenticate(with: credential, completion: {
                    (authResult, error) in
                    if error != nil {
                        self.displayErrorMessage(message:"Password incorrect.")
                    } else {
                        //set a new password
                        let alertController = UIAlertController(title: "Error", message: "Please enter your new password", preferredStyle: .alert)
                        alertController.addTextField()
                        alertController.textFields?[0].placeholder = "New Password"
                        alertController.textFields?[0].isSecureTextEntry = true
                        alertController.addTextField()
                        alertController.textFields?[1].placeholder = "Re-password"
                        alertController.textFields?[1].isSecureTextEntry = true
                        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
                            if let pw = alertController.textFields?[0].text, let rePw = alertController.textFields?[1].text {
                                if (pw == rePw ) {
                                    user?.updatePassword(to:  (alertController.textFields?[0].text)!) { (errror) in
                                        if error != nil{
                                            self.displayErrorMessage(message: "Error in update password. Please try again.")
                                        } else {
                                            self.displayErrorMessage(title:"Success", message: "Your password has been updated.")
                                        }
                                    }
                                }
                                    
                                else {
                                    self.displayErrorMessage(message: "Re-password does not match.")
                                }
                            } else {
                                self.displayErrorMessage(message: "Password cannot be empty")
                            }
                        }
                        
                        //the cancel action doing nothing
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
                        
                        alertController.addAction(confirmAction)
                        alertController.addAction(cancelAction)
                        
                        //finally presenting the dialog box
                        self.present(alertController, animated: false, completion: nil)
                    }
                })
                
                
            }
            
            alertController.addAction(confirmAction)
            //the cancel action doing nothing
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            alertController.addAction(cancelAction)
            
            //finally presenting the dialog box
            self.present(alertController, animated: false, completion: nil)
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refUsers = Database.database().reference().child("user");
        // Do any additional setup after loading the view.
    }
    
    func displayErrorMessage (title: String = "Error", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
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
