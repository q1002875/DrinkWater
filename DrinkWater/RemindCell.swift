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
class RemindCell:UITableViewCell{
    
    var current: DrinkModel!
    @IBOutlet weak var Time: UILabel!
    
    @IBOutlet weak var Remid: UISwitch!
    
    func setProduct(drink:DrinkModel){
        Time.text = drink.drinktime
        Remid.setOn(true, animated: true)
        //這裡設定switch
        
        
        if Remid.isOn == false{
            didremoveremid()
            
        }
    }
    
    func didremoveremid(){
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            for notification:UNNotificationRequest in notificationRequests {
                if notification.identifier == self.current.saveuuid {
                    identifiers.append(notification.identifier)
                }
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
}
