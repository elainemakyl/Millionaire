//
//  SignupViewController.swift
//  Millionare
//
//  Created by delta on 7/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit
import Firebase

import FirebaseAuth
import FirebaseDatabase

class SignupViewController: UIViewController {
    
    var refUsers: DatabaseReference!
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var repwTextField: UITextField!
    
    @IBAction func CreateAccountButton(_ sender: Any) {
        let signUpManager = FirebaseAuthManager()
        if let email = emailTextField.text, let password = pwTextField.text {
            signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                guard self != nil else { return }
                var message: String = ""
                if (success) {
                    self!.addUser()
                    message = "User was sucessfully created."
                } else {
                    message = "There was an error."
                }
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self?.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        FirebaseApp.configure()
        refUsers = Database.database().reference().child("user");
    }
//
    func addUser(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = refUsers.childByAutoId().key

        //creating artist with the given values
        let user = ["id":key,
                    "first_name": firstNameTextField.text! as String,
                    "last_name": lastNameTextField.text! as String,
                    "email" : emailTextField.text! as String
        ]

        //adding the artist inside the generated unique key
        refUsers.child(key!).setValue(user)
    }
    /*
      MARK: - Navigation
     
      In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      Get the new view controller using segue.destination.
      Pass the selected object to the new view controller.
     }
     */
    
}
