//
//  RankingCalc.swift
//  Millionare
//
//  
//  Copyright © 2019 EE4304. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RankingCalc {

    var name: [String]
    var email: [String]
    var Rating: Double
    var Ranking: String

    init(inputname: [String], inputemail: [String]){
        name = inputname
        email = inputemail
        Rating = 1.0
        Ranking = "1"
}
    
    func getRanking() ->String {
        return Ranking
}

}
