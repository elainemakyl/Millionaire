//
//  DatabaseUtil.swift
//  Millionare
//
//
//  Copyright © 2019 EE4304. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class DatabaseUtil {
    static let data = DatabaseUtil()
    var refUsers: DatabaseReference!
    var storageRef: StorageReference!
    var storage: Storage!
    var name: String
    init() {
        // add things here
        name = ""
        storage = Storage.storage()
        storageRef = storage.reference()
        refUsers = Database.database().reference().child("user")
        let user = Auth.auth().currentUser
        let userID = user?.uid
        let firstname = refUsers.child(userID!).child("first_name")
    
        firstname.observe(.value, with : {(Snapshot) in
            if let first = Snapshot.value as? String{ self.name = first + " "}})
    }
    
    
    //remove later
    func getData() -> [String]{
        return ["test"]
    }
    func getName() -> String {
        return name
    }
    
    //to return alluser in db
    func getAllUser() -> [String]{
        var alluser: [String] = []
        
       // alluser = ["test","456","ac","999","test123","yyy"]
        refUsers.observe(.value, with: { (snapshot) in
                       for child in snapshot.children {
                           let snap = child as! DataSnapshot
                           let placeDict = snap.value as! [String: AnyObject]
                           let name = placeDict["first_name"] as! String
                           alluser.append(name)
                       }
                   })
                alluser.append("1")
              /* alluser.append("12")
               alluser.append("123")
               alluser.append("1234")
               alluser.append("12345")
              alluser.append("123456")*/
        return alluser
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
         allemail.append("1")
        allemail.append("12")
        allemail.append("123")
        allemail.append("1234")
        allemail.append("12345")
       allemail.append("123456")
        return allemail
    }
    
}
