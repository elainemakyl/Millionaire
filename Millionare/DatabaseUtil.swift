//
//  DatabaseUtil.swift
//  Millionare
//
//
//  Copyright © 2019 EE4304. All rights reserved.
//

//
//
// USELESS!!!!!!!!!!!!!!!!!!!!!
//
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
     func getAllUser(completion:@escaping (Array<String>, Array<String>) -> Void)  -> Void{
        var alluser: [String] = []
        var allemail:[String]=[]
       // alluser = ["test","456","ac","999","test123","yyy"]
     
       refUsers.observe(.value, with: { (snapshot) in
                       for child in snapshot.children {
                           let snap = child as! DataSnapshot
                           let placeDict = snap.value as! [String: AnyObject]
                           let name = placeDict["first_name"] as! String
                        let email = placeDict["email"] as! String
                        alluser.append(name)
                        allemail.append(email)
                       }
        completion(alluser,allemail)
                   })
                
              /* alluser.append("12")
               alluser.append("123")
               alluser.append("1234")
               alluser.append("12345")
              alluser.append("123456")*/
   
    }
    
    //to return allemail in db
    func getAllEmail() -> [String] {
         var allemail: [String] = []
            
          /*  refUsers.observeSingleEvent(of: .value, with: { snapshot in
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let placeDict = snap.value as! [String: Any]
                    let email = placeDict["email"] as! String
                   
                    allemail.append("123")
                }
            })*/
         allemail.append("1q")
        allemail.append("12")
        allemail.append("123")
        allemail.append("1234")
        allemail.append("12345")
       allemail.append("123456")
        return allemail
    }
    
}
