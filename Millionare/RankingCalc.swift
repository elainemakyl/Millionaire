//
//  RankingCalc.swift
//  Millionare
//
//  
//  Copyright © 2019 EE4304. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class RankingCalc {
    
    static let data = RankingCalc()
    var refUsers :  DatabaseReference!
    //var name: [String]
    //var email: [String]
    //var Rating: Double
    //var Ranking: String
    // var allusers: [String]
     private init() {
        let user = Auth.auth().currentUser
        let userID = user?.uid
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
    
    
    
    func saveRating(_ income: Double, _ spending: Double) -> Double {
       //If income/ spening < 1,  rating = income/spending
       //If income/spending > 1, rating = Sqrt(sqrt(income))/sqrt(sqrt(spending))
        var rating: Double
        if (spending == 0){
            return 0
        }
        else{
        if (income / spending) <= 1{
            rating = income / spending
        }
        else
        {
            rating = sqrt(sqrt(income)) / sqrt(sqrt(spending))
        }
    }
       // print(rating)
        rating = (round(100*rating)/100)
        return  rating
    }
    

}
