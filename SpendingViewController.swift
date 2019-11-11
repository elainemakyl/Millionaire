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

class SpendingViewController: UIViewController {
    
    @IBOutlet var valueText: UITextField!
    @IBOutlet var categoryText: UITextView!
    @IBOutlet var date: UIDatePicker!
    @IBOutlet var titleText: UITextField!
    
    var category: String = ""
    var year: String = ""
    var month: String = ""
    var day: String = ""
    var titleOp: String = ""
    var id = 0
    var value:Double = 0.0

    @IBAction func food(_ sender:AnyObject) {categoryInput(input: "food")}
    @IBAction func cloth(_ sender:AnyObject) {categoryInput(input: "cloth")}
    @IBAction func trafics(_ sender:AnyObject) {categoryInput(input: "trafics")}
    @IBAction func necessary(_ sender:AnyObject) {categoryInput(input: "necessary")}
    @IBAction func entertainment(_ sender:AnyObject) {categoryInput(input: "entertainment")}
    @IBAction func others(_ sender:AnyObject) {categoryInput(input: "others")}
    
    func categoryInput(input: String){
        category = input
        categoryText.text = input
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
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Data Validation Error", message: "There was an error.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: {(action: UIAlertAction!) in print("Data Validation Checking Completed")}))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: AnyObject){
        titleText.text = ""
        valueText.text = ""
        categoryText.text = ""
        category = ""
        year = ""
        month = ""
        day = ""
        value = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
