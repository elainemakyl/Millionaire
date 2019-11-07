//
//  SignupViewController.swift
//  Millionare
//
//  Created by delta on 7/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
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
