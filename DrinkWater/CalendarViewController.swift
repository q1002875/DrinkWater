//
//  ViewController.swift
//  Calendar
//
//  Created by appsgaga on 2017/12/27.
//  Copyright © 2017年 appsgaga. All rights reserved.
//

import UIKit
import AMCalendar
    class CalendarViewController: UIViewController, AMCalendarRootViewControllerDelegate {
        
        
        @IBOutlet weak var label2: UILabel!
        
        
        @IBOutlet weak var calendarBaseView2: UIView!
        
        
        var calendar2: AMCalendarRootViewController?
        
        let dateFormatter = DateFormatter()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "yyyy/MM/dd"
           label2.text = format.string(from: date)
            
            
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
                
                if let date = date {
                    
                    label2.text = dateFormatter.string(from: date)
                }
                
            }
        }
}
