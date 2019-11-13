//
//  SpendingViewController.swift
//  Millionare
//
//  Created by mat on 10/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import UIKit
import FirebaseStorage

class SpendingViewController: UIViewController {
    
    var refUser: DatabaseReference!
    var storageRef: StorageReference!
    var storage: Storage!
    
    @IBOutlet var valueText: UITextField!
//    @IBOutlet var categoryText: UITextView!
    @IBOutlet var date: UIDatePicker!
    @IBOutlet var titleText: UITextField!
    
    var category: String = ""
    var year: String = ""
    var month: String = ""
    var day: String = ""
    var titleOp: String = ""
    var id = 0
    var value:Double = 0.0
    var count = 0
    
    @IBOutlet var buttonSelected: [UIButton]!
    
    // Grey one button if user pressed
    @IBAction func greySelectedButton(_ sender: UIButton) {
        for button in buttonSelected{
            button.backgroundColor = UIColor.clear
        }
        sender.backgroundColor = UIColor.gray
    }
    
    @IBAction func food(_ sender:AnyObject) {categoryInput(input: "food")}
    @IBAction func cloth(_ sender:AnyObject) {categoryInput(input: "cloth")}
    @IBAction func trafics(_ sender:AnyObject) {categoryInput(input: "trafics")}
    @IBAction func necessary(_ sender:AnyObject) {categoryInput(input: "necessary")}
    @IBAction func entertainment(_ sender:AnyObject) {categoryInput(input: "entertainment")}
    @IBAction func others(_ sender:AnyObject) {categoryInput(input: "others")}
    
    func categoryInput(input: String){
        category = input
//        categoryText.text = input
    }
    
    @IBAction func save(_ sender:AnyObject){
        if let tmp = Double(valueText.text!) {            //value input is a value
            if category != "" {
                if titleText.text == ""{                    //have no title
                    titleOp = "nil"
                } else {
                    titleOp = titleText.text!               //have title
                }
                value = tmp
                                                            //update to database
                
            } else {                                        //no category input
                showAlert()
            }
        } else {                                            //value input is not value
            showAlert()
        }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day,.month,.year], from: date.date)
        if let dayGet = components.day, let monthGet = components.month, let yearGet = components.year {
            day = String(dayGet)
            month = String(monthGet)
            year = String(yearGet)
        }
        addSpendingRecord()
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Data Validation Error", message: "There was an error.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: {(action: UIAlertAction!) in print("Data Validation Checking Completed")}))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: AnyObject){
        titleText.text = ""
        valueText.text = ""
//        categoryText.text = ""
        category = ""
        year = ""
        month = ""
        day = ""
        value = 0.0
    }
    
    func addSpendingRecord(){
        storage = Storage.storage()
        storageRef = storage.reference()
        refUser = Database.database().reference().child("user");
        // Do any additional setup after loading the view.
        let user = Auth.auth().currentUser
        let userID = user?.uid
        
        //generating a new key inside artists node
        //and also getting the generated key
        refUser = Database.database().reference().child("spending")
        
        refUser.child(userID!).observe(DataEventType.value, with: { (snapshot) in
          print(snapshot.childrenCount)
            self.count = Int(snapshot.childrenCount)
        })
        
        if count<1{
            refUser.setValue(userID)
        }
        
        count=count+1
        
        //creating artist with the given values
        let spending = ["id": String(count),
                        "category": category,
                        "title": titleOp,
                        "value": String(value),
                        "day": day,
                        "month": month,
                        "year": year
                        ]
    
        //adding the artist inside the generated unique key
        refUser.child(userID!).setValue(count)
        refUser.child(userID!).child(String(count)).setValue(spending)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
