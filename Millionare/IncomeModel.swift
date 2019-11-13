//
//  IncomeModel.swift
//  Millionare
//
//  Created by mat on 13/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import Foundation

class IncomeModel {
    
    var id: String?
    var title: String?
    var value: String?
    var day: String?
    var month: String?
    var year: String?
    
    init(id: String?, title: String?, value: String?, day: String?, month: String?, year: String?){
        self.id = id
        self.title = title
        self.value = value
        self.day = day
        self.month = month
        self.year = year
    }
}
