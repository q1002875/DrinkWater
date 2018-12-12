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
   
    let savetime:String = ""
    var remindtime: DrinkModel!
    @IBOutlet weak var Time: UILabel!
    var delegateswitch:RemindCelldelegate?
    @IBOutlet weak var Remid: UISwitch!
    
    @IBAction func switchchane(_ sender: UISwitch) {
        
        if sender.isOn == true{
            
            let format = DateFormatter()
            format.dateFormat = "HH:mm"
            if let time =  remindtime.drinktime{
                let date = format.date(from: time)
                let content = UNMutableNotificationContent()
                content.title = "補充水分的時間到囉!!!"
                content.body = ""
                content.sound = UNNotificationSound.defaultCritical
                content.badge = NSNumber(integerLiteral: UIApplication.shared.applicationIconBadgeNumber + 1)
                let uuid = UUID().uuidString
                
                let triggerDate = Calendar.current.dateComponents([ .hour, .minute,], from: date!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                let request = UNNotificationRequest(identifier:remindtime.saveuuid!, content: content, trigger: trigger)
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
                    content.badge = NSNumber(integerLiteral: UIApplication.shared.applicationIconBadgeNumber + 1)
                    let uuid = UUID().uuidString
                    
                    let triggerDate = Calendar.current.dateComponents([ .hour, .minute,], from: date!)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                    let request = UNNotificationRequest(identifier:remindtime.saveuuid!, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }

        }else{
            UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
                var identifiers: [String] = []
                for notification:UNNotificationRequest in notificationRequests {
                    if notification.identifier == self.remindtime.saveuuid{
                        identifiers.append(notification.identifier)
                    }
                }
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        }
        delegateswitch?.didcousmtswitch(cell: self)
    }
    
    
        func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
        
 }
    func setProduct(drink:DrinkModel){

        Time.text = drink.drinktime
        
    }


}
