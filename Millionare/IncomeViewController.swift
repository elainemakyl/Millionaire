//
//  IncomeViewController.swift
//  Millionare
//
//  Created by mat on 10/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import UIKit

class IncomeViewController: UIViewController {
    
    var refUser: FIRDatabaseReference!

    @IBOutlet var titleText: UITextField!
    @IBOutlet var valueText: UITextField!
    @IBOutlet var date: UIDatePicker!
    
    var year: String = ""
    var month: String = ""
    var day: String = ""
    var titleOp: String = ""
    var id = 0
    var value:Double = 0.0
    
    @IBAction func save(_ sender:AnyObject){
        if let tmp = Double(valueText.text!) {              //value input is a value
            if titleText.text == ""{                        //have no title
                titleOp = "nil"
            } else {
                titleOp = titleText.text!                   //have title
            }
            value = tmp
                                                            //update database
        } else {
            showAlert()                                     //value input is not value
        }
    }
    
    @IBAction func cancel(_ sender: AnyObject){
        titleText.text = ""
        valueText.text = ""
        year = ""
        month = ""
        day = ""
        value = 0.0
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Data Validation Error", message: "There was an error.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: {(action: UIAlertAction!) in print("Data Validation Checking Completed")}))
        present(alert, animated: true, completion: nil)
    }
    
    func addIncomeRecord(){
        //generating a new key inside artists node
        //and also getting the generated key
        refUser = Database.database().reference().child("income")
        let key = refUser.childByAutoId().key
        
        //creating artist with the given values
        let artist = ["id":key,
                        "artistName": textFieldName.text! as String,
                        "artistGenre": textFieldGenre.text! as String
                        ]
    
        //adding the artist inside the generated unique key
        refArtists.child(key).setValue(artist)
        
        //displaying message
        labelMessage.text = "Artist Added"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
