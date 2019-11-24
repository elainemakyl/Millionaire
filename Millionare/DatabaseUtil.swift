//
//  DatabaseUtil.swift
//  Millionare
//
//
//  Copyright © 2019 EE4304. All rights reserved.
//


import Foundation
import FirebaseDatabase
import FirebaseAuth

class DatabaseUtil {
    static let data = DatabaseUtil()
    var refUsers :  DatabaseReference!
    
   // var allusers: [String]
    private init() {
       refUsers = Database.database().reference().child("user")
    }
    
    
    //remove later
     func getData() -> [String]{
        return ["test"]
    }
     func getName() -> String {
        print("get name method")
        return "eeeeeeee"
    }
    
    //to return alluser in db
     func getAllUser(completion:@escaping (Array<String>, Array<String>, Array<String>) -> Void)  -> Void{
        var alluser: [String] = []
        var allemail: [String] = []
        var ranking: [String] = []
        var num = 0
       // alluser = ["test","456","ac","999","test123","yyy"]
     
       refUsers.observe(.value, with: { (snapshot) in
                       for child in snapshot.children {
                           let snap = child as! DataSnapshot
                           let placeDict = snap.value as! [String: AnyObject]
                           let name = placeDict["first_name"] as! String
                            let email = placeDict["email"] as! String
                        alluser.append(name)
                        allemail.append(email)
                        num = num + 1
                        ranking.append(String(num))
                       }
        completion(alluser,allemail,ranking)
       // print(ranking)
                   })
                
     //  print(ranking)
    }
    
    
    
}
