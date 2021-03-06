//
//  DemoNotificationDelegate.swift
//  DeomoUserNotification
//
//  Created by kevin on 2018/6/30.
//  Copyright © 2018 KevinChang. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class DemoNotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Play sound and show alert to the user
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        // Determine the user action
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
            
        case "SnoozeAction":
            print("Snooze")
            let identifier = "SnoozeNotification"
            let content = response.notification.request.content
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            center.add(request, withCompletionHandler: {(error) in
                if let error = error {
                    print("\(error)")
                }else {
                    print("successed snooze")
                }
            })
            
        case "DeleteAction":
            UIApplication.shared.applicationIconBadgeNumber = 0
        default:
            print("Unknown action")
        }
        
        completionHandler()
    }
    
  
}
