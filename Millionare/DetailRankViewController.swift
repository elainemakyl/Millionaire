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
    
    @IBAction func CrossButton(_ sender: Any) {
     self.dismiss(animated:true, completion:nil)
    }
    
    
    var name: String? = ""
    var Sranking: String? = ""
    var Sspending: String? = ""
    var Ssaving: String? = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //return the name of selected row
        nameLabel.text = name
        ranking.text = Sranking
        spending.text = Sspending
        saving.text = Ssaving
        
        
        let data = DatabaseUtil.data.getData()
        
       // ranking.text = DatabaseUtil.data.getName()
        spending.text = data[0]
       
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
