//
//  SecondViewController.swift
//  Millionare
//
//  Created by delta on 5/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit

class RankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let items:[String] = ["test","456","ac","999"]
    let email:[String] = ["hi@gmail.com", "you@gmail.com", "test@gmail.com", "ac@gmail.com"]
    
    @IBOutlet var table: UITableView!
    

    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RankTableViewCell
   //  cell.textLabel?.text = items[indexPath.row]
        
        cell.nameLabel.text = items[indexPath.row]
        cell.emailLabel.text = email[indexPath.row]
        cell.rankLabel.text = "Rank " + String(indexPath.row + 1)
        return cell
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "ShowRankSegue", let destination = segue.destination as? DetailRankViewController, let rankindex = table.indexPathForSelectedRow?.row {
      //     destination.label.text = "ok"
        }
    
    }

    override func viewWillAppear(_ animated: Bool) {
        
        table.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

