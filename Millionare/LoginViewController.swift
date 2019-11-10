//
//  LoginViewController.swift
//  Millionare
//
//  Created by delta on 7/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {

    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBAction func SigninButton(_ sender: Any) {
         let loginManager = FirebaseAuthManager()
            guard let email = emailTextField.text, let password = pwTextField.text else { return }
            loginManager.signIn(email: email, pass: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully logged in."
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                       let vc =  storyboard.instantiateViewController(withIdentifier: "MainViewController") as UIViewController
                                       self.present(vc, animated: true, completion: nil)
       
                } else {
                    message = "There was an error."
                    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alertController, animated: true, completion: nil)
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
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }

        print("handle user signup / login")
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: FirebaseAuth.User?, error: Error?) {
        // ...
        let user: FIRUser? = Auth.auth().currentUser
    }
}
