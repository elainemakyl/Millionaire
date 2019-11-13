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

    let items:[String] = ["test","456","ac","999"]
    let email:[String] = ["hi@gmail.com", "you@gmail.com", "test@gmail.com", "ac@gmail.com"]
    
    @IBOutlet var table: UITableView!
    

    @IBOutlet var searchBar: UISearchBar!
    
    
    
    var filterData: [String]!
    
    
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
        cell.emailLabel.text = email[indexPath.row]
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
        filterData = items
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

