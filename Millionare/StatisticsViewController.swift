//
//  StatisticsViewController.swift
//  Millionare
//
//  Created by delta on 7/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit
import Charts
import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class StatisticsViewController: UIViewController {
    
    
    
    var refUser: DatabaseReference!
    var storageRef: StorageReference!
    var storage: Storage!
    var monthFlag = true
    var weekFlag = false
    var dayFlag = false
    
    var months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var category: [String]!
    var monthValue: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    var spendingList = [SpendingModel]()

    @IBOutlet var lineChart: LineChartView!
    @IBOutlet var pieChart: PieChartView!
    
    @IBOutlet var monthWeekDay: UISegmentedControl!
    @IBAction func MonthWeekDay(_ sender: Any) {
        if monthWeekDay.selectedSegmentIndex == 1{
            monthFlag = true
            weekFlag = false
            dayFlag = false
        } else if monthWeekDay.selectedSegmentIndex == 2{
            monthFlag = false
            weekFlag = true
            dayFlag = false
        } else {
            monthFlag = false
            weekFlag = false
            dayFlag = true
        }
        chartDataFromFB()
    }
    
    override func viewDidLoad() {
        
        chartDataFromFB()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // abc
    }
    
    func chartDataFromFB(){
        
        storage = Storage.storage()
        storageRef = storage.reference()
        refUser = Database.database().reference().child("user");
        // Do any additional setup after loading the view.
        let user = Auth.auth().currentUser
        let userID = user?.uid
        
        //generating a new key inside artists node
        //and also getting the generated key
        refUser = Database.database().reference().child("spending").child(String(userID!))
        
        refUser.observe(.value, with: {  (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {

                //self.spendingList.removeAll()

                //iterating through all the values
                for records in snapshot.children {
                    //getting values
                    let spendings = records as! DataSnapshot
                    
                    let spendingObject = spendings.value as? [String: AnyObject]
                    let spendingYear  = spendingObject?["year"]
                    let spendingMonth  = spendingObject?["month"]
                    let spendingDay = spendingObject?["day"]
                    let spendingValue = spendingObject?["value"]
                    let spendingCategory = spendingObject?["category"]
                    let spendingUserID = spendingObject?["userID"]
                    let spendingTitle = spendingObject?["title"]
                    let spendingID = spendingObject?["id"]
                    
                    
                    //creating artist object with model and fetched values
                    let spending = SpendingModel(userID: spendingUserID as! String?, title: spendingTitle as! String?, value: spendingValue as! String?, day: spendingDay as! String?, month: spendingMonth as! String?, year: spendingYear as! String?, category: spendingCategory as! String?, id: spendingID as! String?)
                    
                    //appending it to list
                    self.spendingList.append(spending)
                }
                if self.monthFlag{
                    self.monthLineChartGen()
                } else if self.weekFlag{
                    self.weekLineChartGen()
                } else {
                    self.dayLineChartGen()
                }
                
            }

        })
        
    }
    
    func monthLineChartGen(){
        let date = Date()
        let calendar = Calendar.current
        let currentYear = String(calendar.component(.year, from: date))
        
        for spending in spendingList{
            if spending.year == currentYear{
                switch spending.month {
                case "1":
                    monthValue[0] += Double(spending.value!)!
                    break
                case "2":
                    monthValue[1] += Double(spending.value!)!
                    break
                case "3":
                    monthValue[2] += Double(spending.value!)!
                    break
                case "4":
                    monthValue[3] += Double(spending.value!)!
                    break
                case "5":
                    monthValue[4] += Double(spending.value!)!
                    break
                case "6":
                    monthValue[5] += Double(spending.value!)!
                    break
                case "7":
                    monthValue[6] += Double(spending.value!)!
                    break
                case "8":
                    monthValue[7] += Double(spending.value!)!
                    break
                case "9":
                    monthValue[8] += Double(spending.value!)!
                    break
                case "10":
                    monthValue[9] += Double(spending.value!)!
                    break
                case "11":
                    //print(spending.value!)
                    monthValue[10] += Double(spending.value!)!
                    break
                case "12":
                    monthValue[11] += Double(spending.value!)!
                    break
                default:
                    break
                }
            }
        }
        var dataEntries = [ChartDataEntry]()
        let monthNum = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0]
        
        for i in 0...11 {
            let value = ChartDataEntry(x: monthNum[i] , y: monthValue[i])
            //print(monthValue[i])
            dataEntries.append(value)
        }
        
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Spending Value")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        //let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChart.data = lineChartData
    }
    
    func weekLineChartGen(){
        let oneDayMoreMonth = [1,3,5,7,8,10,12]
        let oneDayLessMonth = [2,4,6,9,11]
        
        let date = Date()
        let calendar = Calendar.current
        let currentYear = String(calendar.component(.year, from: date))
        let currentMonth = String(calendar.component(.month, from: date))
        let currentDay = String(calendar.component(.day, from: date))
        
        for spending in spendingList{
            if spending.year == currentYear{
                if Int(currentDay)! > 6 {
                    let dayNow = Int(currentDay)!
                    var weekNums = [Int]()
                    for i in dayNow-6 ..< dayNow {
                        weekNums[i] = Int(dayNow-6+i)
                    }
                    
                    
                } else {
                    
                }
                switch spending.month {
                case "1":
                    monthValue[0] += Double(spending.value!)!
                    break
                case "2":
                    monthValue[1] += Double(spending.value!)!
                    break
                case "3":
                    monthValue[2] += Double(spending.value!)!
                    break
                case "4":
                    monthValue[3] += Double(spending.value!)!
                    break
                case "5":
                    monthValue[4] += Double(spending.value!)!
                    break
                case "6":
                    monthValue[5] += Double(spending.value!)!
                    break
                case "7":
                    monthValue[6] += Double(spending.value!)!
                    break
                case "8":
                    monthValue[7] += Double(spending.value!)!
                    break
                case "9":
                    monthValue[8] += Double(spending.value!)!
                    break
                case "10":
                    monthValue[9] += Double(spending.value!)!
                    break
                case "11":
                    //print(spending.value!)
                    monthValue[10] += Double(spending.value!)!
                    break
                case "12":
                    monthValue[11] += Double(spending.value!)!
                    break
                default:
                    break
                }
            }
        }
        var dataEntries = [ChartDataEntry]()
        let monthNum = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0]
        
        for i in 0...11 {
            let value = ChartDataEntry(x: monthNum[i] , y: monthValue[i])
            //print(monthValue[i])
            dataEntries.append(value)
        }
        
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Spending Value")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        //let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChart.data = lineChartData
    }
    
    func dayLineChartGen(){
        
    }
    
    func pieChartGen(){
        
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
