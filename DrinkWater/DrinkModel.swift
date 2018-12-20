//
//  DrinkModel.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/9.
//  Copyright © 2018 orange. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class DrinkModel:NSManagedObject{
    
    @NSManaged var saveuuid : String?
    @NSManaged var drinktime : String?
    @NSManaged var  drinkcapacity: NSNumber?
    @NSManaged var switc : NSNumber
    override func awakeFromInsert() {
        drinkcapacity = NSNumber(integerLiteral: 0)
        
        //設定
        switc = NSNumber(booleanLiteral: true)
        //取值
//        switc?.boolValue
    }
}
