//
//  RemindCell.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/9.
//  Copyright © 2018 orange. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
protocol RemindCelldelegate {
    func didcousmtswitch(cell:RemindCell)
}
class RemindCell:UITableViewCell{
    
    @IBOutlet weak var remindText: UILabel!
    let savetime:String = ""
    var remindtime: DrinkModel!
    @IBOutlet weak var Time: UILabel!
    var delegateswitch:RemindCelldelegate?
    @IBOutlet weak var Remid: UISwitch!
    
    @IBAction func switchchane(_ sender: UISwitch) {
        
        if sender.isOn == true{
            let formatt = DateFormatter()
            formatt.dateFormat = "HH:mm"
            let newtime = "00:00"
            let newdate = formatt.date(from: newtime)
            let format = DateFormatter()
            format.dateFormat = "HH:mm"
            if let time =  remindtime.drinktime{
                let date = format.date(from: time)
                let content = UNMutableNotificationContent()
                content.title = "補充水分的時間到囉!!!"
                content.body = ""
                content.sound = UNNotificationSound.defaultCritical
                let triggerDate = Calendar.current.dateComponents([ .hour, .minute,], from: date ?? newdate!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                let request = UNNotificationRequest(identifier:remindtime.drinktime ?? "123", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

            }else{
                
                let format = DateFormatter()
                format.dateFormat = "HH:mm"
                let time = self.Time.text
                let date = format.date(from: time!)
                let content = UNMutableNotificationContent()
                content.title = "補充水分的時間到囉!!!"
                content.body = ""
                content.sound = UNNotificationSound.defaultCritical
                let triggerDate = Calendar.current.dateComponents([ .hour, .minute,], from: date ?? newdate!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                let request = UNNotificationRequest(identifier:remindtime.drinktime ?? "123", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
                
            }
            remindtime.switc = NSNumber(booleanLiteral:true)
            CoreDataHelper.shared.saveContext()
        }else{
            
            remindtime.switc = NSNumber(booleanLiteral:false)
            
            UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
                var identifiers: [String] = []
                for notification:UNNotificationRequest in notificationRequests {
                    if notification.identifier == self.remindtime.drinktime ?? "123"{
                        identifiers.append(notification.identifier)
                    }
                }
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
            }
            CoreDataHelper.shared.saveContext()
            delegateswitch?.didcousmtswitch(cell: self)
            
        }
        
   
        
    }
    func setProduct(drink:DrinkModel){
        
        Time.text = drink.drinktime
        Remid.isOn = drink.switc.boolValue
        
    }
    
    
}
