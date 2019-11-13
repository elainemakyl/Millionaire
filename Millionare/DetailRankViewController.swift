//
//  DetailRankViewController.swift
//  Millionare
//
//  
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit

class DetailRankViewController: UIViewController {

    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var rating: UILabel!
    @IBOutlet var spending: UILabel!
    @IBOutlet var saving: UILabel!
    @IBOutlet var ranking: UILabel!
    
    var name:String? = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
