//
//  RemindCell.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/9.
//  Copyright © 2018 orange. All rights reserved.
//

import Foundation
import UIKit

class RemindCell:UITableViewCell{
    
    
    @IBOutlet weak var Time: UILabel!
    
    @IBOutlet weak var Remid: UISwitch!
    
    
    
    func setProduct(drink:DrinkModel){
        Time.text = drink.drinktime
      
        
        
    }
}
