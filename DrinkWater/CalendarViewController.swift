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
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var howdrink: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var calendarBaseView2: UIView!
    
    var count = 0
    var calendar2: AMCalendarRootViewController?
    
    let dateFormatter = DateFormatter()
    var dateee = ""
    let date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateg =  defaults.dictionary(forKey: dateFormatter.string(from: self.date))
        
        for item in dateg ?? ["":0]{
            
            self.count = item.value as! Int
            
        }

       
//        label2.text = format.string(from: date)
        
        howdrink.text = "\(count)cc"
        
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
                
//                label2.text = dateFormatter.string(from: date)
                let datt = formatter.string(from: date)
                if  let  datecount =  defaults.dictionary(forKey: datt) as? [String : Int]{
                    for item in datecount {
                        self.count = item.value
                        howdrink.text = "\(count)cc"
                    }
                    
                }else{
                    howdrink.text = "無飲水紀錄"
                    
                    
                }
                
            }
            
        }
    }
    
}
