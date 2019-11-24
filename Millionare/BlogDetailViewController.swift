//
//  BlogDetailViewController.swift
//  Millionare
//
//  Created by Michael Chan on 13/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit

class BlogDetailViewController: UIViewController {
    var blogIcon=String()
    var blogTitle=String()
    var blogContent=String()
    
    @IBOutlet var mTitle: UILabel!
    
    @IBOutlet var mIcon: UIImageView!
    
    @IBOutlet var mContent: UITextView!
    
    @IBAction func exitBtn(_ sender: Any) {
        
        self.dismiss(animated:true, completion:nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        mTitle.text=blogTitle
        mContent.text=blogContent
        let myurl = URL(string: blogIcon)
        let data = try? Data(contentsOf: myurl!)
        mIcon.image = UIImage(data:data!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
