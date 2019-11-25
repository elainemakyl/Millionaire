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
    
    
    var items:[String] = []
    var email:[String] = []
    var ranking:[String] = []
    var incomes: [String] = []
    var spendings: [String] = []
    var rating: [String] = []
    
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
            
            // the following are to pass the selected user data to detailrankview
            destination.name = filterData[rankindex!]
            destination.Sranking = filterranking[rankindex!]
            destination.Ssaving = incomes[rankindex!]
            destination.Sspending = spendings[rankindex!]
            destination.Srating = rating[rankindex!]
           //print(incomes)
           // print(spendings)
            
        }
    }
    
    // Update filterdata when user type in searchbar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = searchText.isEmpty ? items : items.filter({(dataString: String) -> Bool in return dataString.range(of: searchText, options: .caseInsensitive) != nil })
       
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
  
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DatabaseUtil.data.getAllUser(completion:{(names,emails,ranking,income,spending,rating) in
                 self.items = names
                 self.email = emails
            self.ranking = ranking
            self.incomes = income
            self.spendings = spending
            self.rating = rating
            self.table.reloadData()
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
        
      // the following is uses to search the users with their data
        DatabaseUtil.data.getAllUser(completion:{(names,emails,ranking,income,spending,rating) in
            self.items = names
            self.email = emails
        self.ranking = ranking
        self.incomes = income
        self.spendings = spending
        self.rating = rating
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

