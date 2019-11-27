//
//  SecondViewController.swift
//  Millionare
//
//  Created by delta on 5/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage


class RankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private let cache = NSCache<AnyObject,AnyObject>()
    
    var refUsers: DatabaseReference!
    var storageRef: StorageReference!
    var storage: Storage!
    
    
    var items:[String] = []
    var email:[String] = []
    var ranking:[String] = []
    var incomes: [String] = []
    var spendings: [String] = []
    var rating: [String] = []
    var icon: [String] = []
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    
    
    var filterData: [String]!
    var filteremail: [String] = []
    var filterranking: [String] = []
    var filterincomes: [String] = []
    var filterspendings: [String] = []
    var filterrating: [String] = []
    var filtericonURL: [String] = []
    var iconURL: [String] = []
    var filtericonPos: [Int] = []
    
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
        cell.rankLabel.text = filterranking[indexPath.row]
        
        if filtericonURL[indexPath.row].elementsEqual("none")  {
            cell.UserIcon.image = UIImage(named: "default_usericon")
        }
        else {
            if (self.filtericonURL.count == self.icon.count){  //not searching
                if let img = cache.object(forKey: self.iconURL[indexPath.row] as AnyObject) as? UIImage{
                    cell.UserIcon.image = img   //already in cache
                }
                else{   //image not in cache
                    
                    
                    var final_img = UIImage()
                    DispatchQueue.global(qos: .background).async{  //download image in background
                        
                        self.storageRef = Storage.storage().reference()
                        let filepath =  self.filtericonURL[indexPath.row]
                        //make sure doesnt mess with image in cache
                        self.storageRef.child(filepath).downloadURL { (url, error) in
                            guard let dlurl = url else {return}
                            self.iconURL[indexPath.row] = dlurl.absoluteString
                            self.filtericonURL[indexPath.row] = dlurl.absoluteString
                            let myurl = URL(string: self.filtericonURL[indexPath.row])
                            
                            URLSession.shared.dataTask(with: myurl!, completionHandler: { (data, response, error) in

                                //print("RESPONSE FROM API: \(response)")
                                if error != nil {
                                    print("ERROR LOADING IMAGES FROM URL: \(error)")
//                                    DispatchQueue.main.async {
//                                        self.image = placeHolder
//                                    }
//                                    return
                                }
                                DispatchQueue.main.async {
                                    if let data = data {
                                        if let downloadedImage = UIImage(data: data) {
                                            self.cache.setObject(downloadedImage, forKey:  self.filtericonURL[indexPath.row] as AnyObject)
                                            print(self.filtericonURL[indexPath.row])
                                            cell.UserIcon.image = final_img
                                            
                                            self.table.reloadData()
                                        }
                                    }
                                }
                            }).resume()
                            
                           
                        
                        }
                        
                    }
                    
                }
            } else {    //alredy cached photos => no need to retrieve db again
                //find out the position in original list
                let pos = filtericonPos[indexPath.row]
                print(icon[pos])
                if let img = cache.object(forKey: self.iconURL[pos] as AnyObject) as? UIImage{
                    cell.UserIcon.image = img   //already in cache
                }
            }
        }
        
        return cell
        
    }
    
    
    // to call detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "ShowRankSegue" {
            view.endEditing(true)
            let destination = segue.destination as! DetailRankViewController
            let rankindex = table.indexPathForSelectedRow?.row
            
            // the following are to pass the selected user data to detailrankview
            destination.name = filterData[rankindex!]
            destination.Sranking = filterranking[rankindex!]
            destination.Ssaving = filterincomes[rankindex!]
            destination.Sspending = filterspendings[rankindex!]
            destination.Srating = filterrating[rankindex!]
            
            
            
        }
    }
    
    // Update filterdata when user type in searchbar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = searchText.isEmpty ? items : items.filter({(dataString: String) -> Bool in return dataString.range(of: searchText, options: .caseInsensitive) != nil })
        
        filteremail = []
        filterincomes = []
        filterrating = []
        filterranking = []
        filterspendings = []
        filtericonURL = []
        
        filtericonPos = []
        var isfound = false
        
        for info in filterData {
            for i in 0 ... items.count {
                
                if info == items[i] && isfound == false {
                    filterincomes.append(incomes[i])
                    filterspendings.append(spendings[i])
                    filterrating.append(rating[i])
                    filteremail.append(email[i])
                    filterranking.append(ranking[i])
                    filtericonURL.append(icon[i])
                    filtericonPos.append(i)
                    //                    print(filterranking)
                    isfound = true
                    break
                }
                isfound = false
            }
        }
        table.reloadData()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DatabaseUtil.data.getAllUser(completion:{(names,emails,ranking,income,spending,rating,usericon) in
            self.items = names
            self.email = emails
            self.ranking = ranking
            self.incomes = income
            self.spendings = spending
            self.rating = rating
            self.icon = usericon
            self.table.reloadData()
        })
        self.filterData = self.items
        self.filteremail = self.email
        self.filterranking = self.ranking
        self.filterspendings = self.spendings
        self.filterrating = self.rating
        self.filterincomes = self.incomes
        self.filtericonURL = self.icon
        self.iconURL = self.icon
        
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
        
        searchBar.resignFirstResponder()    //hide keyboard
        
        storage = Storage.storage()
        storageRef = storage.reference()
        
        // the following is uses to search the users with their data
        DatabaseUtil.data.getAllUser(completion:{(names,emails,ranking,income,spending,rating,usericon) in
            self.items = names
            self.email = emails
            self.ranking = ranking
            self.incomes = income
            self.spendings = spending
            self.rating = rating
            self.icon = usericon
        })
        self.filterData = self.items
        self.filtericonURL = self.icon
        self.filtericonURL = self.icon
        self.table.reloadData()
        
        filterData = self.items
        table.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func displayErrorMessage (title: String = "Error", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
    
}

