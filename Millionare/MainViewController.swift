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
import Floaty

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refUsers: DatabaseReference!
    var storageRef: StorageReference!
    var storage: Storage!
    var incomes: Double = 0.0
    var spendings: Double = 0.0
    var ratings: Double = 0.0
    var issave = false
    
    @IBOutlet var userButton: UIButton!
    @IBOutlet weak var floaty: Floaty!
    @IBOutlet weak var UITableView: UITableView!
    
    @IBAction func iconButton(_ sender: Any) {
        let optionMenu = UIAlertController(title: "Action", message: "Please select the action", preferredStyle: .actionSheet)
        let settings = UIAlertAction(title: "Settings", style: .default, handler: {(alert: UIAlertAction!) -> Void in
            //go to setting page
            self.performSegue(withIdentifier: "goToSettings", sender: nil)
        })
        let signout = UIAlertAction(title: "Sign Out", style: .default, handler: {(alert: UIAlertAction!) -> Void in
            //logout
            self.saveUserData()
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
    
    // override table view with animation
    let hardCode:[String] = ["This is a hard code:", "Food $20", "Drink $50", "Cloth $80", "Others $60", "Food $100", "Drink $80", "Food $20", "Drink $50", "Cloth $80", "Others $60", "Food $100", "Drink $80"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hardCode.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel?.text = hardCode[indexPath.row]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = Storage.storage()
        storageRef = storage.reference()
        refUsers = Database.database().reference().child("user");
        // Do any additional setup after loading the view.
        let user = Auth.auth().currentUser
        let userID = user?.uid
        
        
        //retrieve profile pic url
        refUsers.child(userID!).observe(.value, with: { (snapshot) in
            // check if user has photo
            if snapshot.hasChild("userPhoto"){
//                 set image locatin
                let filePath = "\(userID!)/\("userPhoto")"
                // Assuming a < 10MB file, though you can change that
                self.storageRef.child(filePath).getData(maxSize: 10*1024*1024, completion: { (data, error) in

//                    let userPhoto = UIImage(data: data!)
//                    self.userButton.setBackgroundImage(userPhoto, for: .normal)
//                    UserDefaults.standard.set(data, forKey: "icon")
                })
            } else {
                //Offline -> load from local
                if let iconData = UserDefaults.standard.object(forKey: "icon")  {
                          let icon = UIImage(data: iconData as! Data)
                    self.userButton.setBackgroundImage(icon, for: .normal)
                          
                      }
            }
        })
        
        //by leo
        DatabaseUtil.data.getUserIncome(completion:{(income) in
            self.incomes = income
        })
        DatabaseUtil.data.getUserSpending(completion:{(spending) in
            self.spendings = spending
        })
      
         //by leo
        
        // Floating Action Button
        floaty.addItem(title: "Add Spending Record", handler: {_ in
            self.performSegue(withIdentifier: "MainToSpending", sender: self)
        })
        floaty.addItem(title: "Add Income Record", handler: {_ in
            self.performSegue(withIdentifier: "MainToIncome", sender: self)
        })
        self.view.addSubview(floaty)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        storage = Storage.storage()
        storageRef = storage.reference()
        refUsers = Database.database().reference().child("user");
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
        
        if let iconData = UserDefaults.standard.object(forKey: "icon")  {
            //retrieve icon from local
            let icon = UIImage(data: iconData as! Data)
            userButton.setBackgroundImage(icon, for: .normal)
            
        }
        
        // tableView animation
        func animateTable() {
            UITableView.reloadData()
            let cells = UITableView.visibleCells
            let tableViewWidth = UITableView.bounds.size.width
            
            for cell in cells {
                cell.transform = CGAffineTransform(translationX: tableViewWidth, y: 0)
            }
            
            var delayCounter: Double = 0
            for cell in cells {
                UIView.animate(withDuration: 0.5, delay: delayCounter * 0.5, options: .curveEaseIn, animations: {
                    cell.transform = CGAffineTransform.identity
                }, completion: nil)
                delayCounter += 0.05
            }
        }
        
        // hide navigation bar on this page
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        animateTable()
        
        print(spendings)
    }
    
    // show navigation bar again on other pages
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        super.viewWillDisappear(animated)
        refUsers = Database.database().reference().child("user");
        // Do any additional setup after loading the view.
        /*
        
        let user = Auth.auth().currentUser
        //let userid = user?.uid
        if (issave == false){
        // calc the rating for current user
        ratings = RankingCalc.data.saveRating(incomes, spendings)
        print(ratings)
            issave = true
            let userid = Auth.auth().currentUser?.uid
            //getting the input values from user
             self.refUsers.child(userid!).child("spending").setValue(spendings)
                self.refUsers.child(userid!).child("income").setValue(incomes)
            self.refUsers.child(userid!).child("rating").setValue(ratings)
            
        }
         */
        
    }
    
    func saveUserData(){
        refUsers = Database.database().reference().child("user");
        // Do any additional setup after loading the view.
        //let user = Auth.auth().currentUser
        //let userid = user?.uid
        if (issave == false){
        // calc the rating for current user
        ratings = RankingCalc.data.saveRating(incomes, spendings)
        print(ratings)
            issave = true
            let userid = Auth.auth().currentUser?.uid
            //getting the input values from user
             self.refUsers.child(userid!).child("spending").setValue(spendings)
                self.refUsers.child(userid!).child("income").setValue(incomes)
            self.refUsers.child(userid!).child("rating").setValue(ratings)
            
        }
    }
}

