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
     
        refUsers.queryOrdered(byChild: "rating").observe(.value, with: { (snapshot) in
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
            completion(alluser.reversed(),allemail.reversed(),ranking)
       // print(ranking)
                   })
                
     //  print(ranking)
    }
    
    func getUserIncome(completion:@escaping (Double) -> Void)  -> Void{
        let user = Auth.auth().currentUser
        let userID = user?.uid
        let ref = Database.database().reference().child("income").child(String(userID!))

        var num: Double = 0.0
         var temp: [String] = []
       // alluser = ["test","456","ac","999","test123","yyy"]
     
       ref.observe(.value, with: { (snapshot) in
                       for child in snapshot.children {
                           let snap = child as! DataSnapshot
                           let placeDict = snap.value as! [String: AnyObject]
                           let value = placeDict["value"] as! String
                        temp.append(value)
                       }
        for item in temp{
            num += Double(item)!
        }
        completion(num)
       // print(num)
                   })
     // print(num)
    }
    
    func getUserSpending(completion:@escaping (Double) -> Void)  -> Void{
        let user = Auth.auth().currentUser
        let userID = user?.uid
        let ref = Database.database().reference().child("spending").child(String(userID!))

        var num: Double = 0.0
         var temp: [String] = []
       // alluser = ["test","456","ac","999","test123","yyy"]
     
       ref.observe(.value, with: { (snapshot) in
                       for child in snapshot.children {
                           let snap = child as! DataSnapshot
                           let placeDict = snap.value as! [String: AnyObject]
                           let value = placeDict["value"] as! String
                        temp.append(value)
                       }
        for item in temp{
            num += Double(item)!
        }
        completion(num)
       // print(num)
                   })
     // print(num)
    }
    
}
