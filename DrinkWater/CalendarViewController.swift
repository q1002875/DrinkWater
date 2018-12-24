//
//  ViewController.swift
//  Calendar
//
//  Created by appsgaga on 2017/12/27.
//  Copyright © 2017年 appsgaga. All rights reserved.
//

import UIKit
import CoreData
import AMCalendar
    class CalendarViewController: UIViewController, AMCalendarRootViewControllerDelegate {
        
        
        @IBOutlet weak var howdrink: UILabel!
        @IBOutlet weak var label2: UILabel!
        
        
        @IBOutlet weak var calendarBaseView2: UIView!
        
        
        var calendar2: AMCalendarRootViewController?
        
        let dateFormatter = DateFormatter()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
               loadfromdata()
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "yyyy/MM/dd"
           label2.text = format.string(from: date)
            howdrink.text = "\(self.datevalue)cc"
            
            calendar2 =
                AMCalendarRootViewController.setCalendar(onView: calendarBaseView2,
                                                         parentViewController: self,
                                                         selectedDate: nil,
                                                         delegate: self)
      
            dateFormatter.locale = Locale(identifier: "ja_JP")
            dateFormatter.dateFormat = "yyyy/MM/dd"
            
       
            
        }

        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        
        
        func calendarRootViewController(calendarRootViewController: AMCalendarRootViewController,
                                        didSelectDate date: Date?) {
            
            if calendar2 == calendarRootViewController {
                
                let formatter = dateFormatter
                
                formatter.dateFormat = "yyyy/MM/dd"
//                let dateee =  formatter.date(from: data[1].dateID!)
                
                if let date = date {
                    
                    label2.text = dateFormatter.string(from: date)
                    
//                    howdrink.text = data.last?.datedrink
//                    print("\(date)")
                    
                    
                }
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-MM-dd"
                
                let datekey = dateFormatter.date(from: self.datekey)
                
                if datekey == date{
                    howdrink.text = "\(self.datevalue)cc"
                    
                }else{
                        howdrink.text = "無飲水紀錄"
                        
                    }
                
                
//                if self.date?.
//                    == date{
//                  loadfromdata()
//                }
                
            }
        }
        
        var date :[String:Int]?
        var datekey : String = ""
        var datevalue : Int = 0
        func loadfromdata(){
            do{
                let url = URL(fileURLWithPath: NSHomeDirectory())
                let fileurl = url.appendingPathComponent("mydata.plist")
                let data = try Data(contentsOf: fileurl)
                var format = PropertyListSerialization.PropertyListFormat.xml
                let date = try (PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: &format) as? [String:Int])
                
                for item in date! {
                    datekey =  item.key
                    datevalue = item.value
                }
                
                
            }catch{
                print("error")
                
            }
            
        }

}
