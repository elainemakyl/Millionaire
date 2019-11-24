//
//  SecondViewController.swift
//  Millionare
//
//  Created by delta on 5/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit
import FirebaseDatabase


class RankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var refUsers: DatabaseReference!
    
    
    //let items:[String] = ["test","456","ac","999"]
    //  let email:[String] = ["hi@gmail.com", "you@gmail.com", "test@gmail.com", "ac@gmail.com","abc@gmail.com", "noob@gmail.com"]
    var items:[String] = []//DatabaseUtil.data.getAllUser()
    var email:[String] = []
    var ranking:[String] = []
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    var filterData: [String]!
    var filteremail: [String]!
    var filterranking: [String]!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RankTableViewCell
        cell.nameLabel.text = filterData[indexPath.row]
        cell.emailLabel.text = filteremail[indexPath.row]
        cell.rankLabel.text = "Rank " + filterranking[indexPath.row]
        return cell
        
    }
    
    
    // to call detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "ShowRankSegue" {
            
            let destination = segue.destination as! DetailRankViewController
            let rankindex = table.indexPathForSelectedRow?.row
            
            destination.name = filterData[rankindex!]
            destination.Sranking = filterranking[rankindex!]
            print(filterData!)
            print(email)
            
            RankingCalc.data.saveRating(12333, 1123)
            
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       /* DatabaseUtil.data.getAllUser(completion:{(names,emails) in
            self.items = names
            self.email = emails

        })
        self.filterData = self.items
        self.filteremail = self.email
        self.table.reloadData()
        print(filterData!)*/
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DatabaseUtil.data.getAllUser(completion:{(names,emails,ranking) in
                 self.items = names
                 self.email = emails
            self.ranking = ranking
                 
             })
             self.filterData = self.items
             self.filteremail = self.email
            self.filterranking = self.ranking
             self.table.reloadData()
             
             filterData = self.items
        //     filteremail = self.email
       // filterranking = self.ranking
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.dataSource = self
        searchBar.delegate = self
       DatabaseUtil.data.getAllUser(completion:{(names,emails,ranking) in
            self.items = names
            self.email = emails
        self.ranking = ranking
        })
        self.filterData = self.items
      //  self.filteremail = self.email
      //  self.filterranking = self.ranking
        self.table.reloadData()
        
     //   let Ranking = RankingCalc(inputname: items, inputemail: email)
      //  filteruid = uid
        filterData = self.items
      //  filteremail = self.email
      //  filterranking = self.ranking
        
        table.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

