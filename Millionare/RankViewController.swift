//
//  SecondViewController.swift
//  Millionare
//
//  Created by delta on 5/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class RankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var refUsers: DatabaseReference!
       var storageRef: StorageReference!
       var storage: Storage!
    
    //let items:[String] = ["test","456","ac","999"]
 //  let email:[String] = ["hi@gmail.com", "you@gmail.com", "test@gmail.com", "ac@gmail.com","abc@gmail.com", "noob@gmail.com"]
    var items:[String] = []//DatabaseUtil.data.getAllUser()
  var email:[String] = []
    
    @IBOutlet var table: UITableView!
    

    @IBOutlet var searchBar: UISearchBar!
    
    var filterData: [String]!
    var filteremail: [String]!
   
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RankTableViewCell
   //  cell.textLabel?.text = items[indexPath.row]
        
       cell.nameLabel.text = filterData[indexPath.row]
        cell.emailLabel.text = filteremail[indexPath.row]
        cell.rankLabel.text = "Rank " + String(indexPath.row + 1)
        return cell
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "ShowRankSegue"{
            let destination = segue.destination as! DetailRankViewController
            let rankindex = table.indexPathForSelectedRow?.row
            destination.name = filterData[rankindex!]
        }
    }
    
    
    // Update filterdata when user type in searchbar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = searchText.isEmpty ? items : items.filter({(dataString: String) -> Bool in return dataString.range(of: searchText, options: .caseInsensitive) != nil })
        //
        table.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        table.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.dataSource = self
        searchBar.delegate = self
       
        storage = Storage.storage()
        storageRef = storage.reference()
        refUsers = Database.database().reference().child("user")
        refUsers.observe(.value, with: { (snapshot) in
                              for child in snapshot.children {
                                  let snap = child as! DataSnapshot
                                  let placeDict = snap.value as! [String: AnyObject]
                                  let name = placeDict["first_name"] as! String
                                let email = placeDict["email"] as! String
                                self.items.append(name)
                                self.email.append(email)
                          //      print(name)
                            //    print(self.items)
                            
                              }
           self.filterData = self.items
            self.filteremail = self.email
            self.table.reloadData()
                          })
     //   let Ranking = RankingCalc(inputname: items, inputemail: email)
        filterData = self.items
        filteremail = self.email
        table.reloadData()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

