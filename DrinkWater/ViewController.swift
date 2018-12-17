//
//  ViewController.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/8.
//  Copyright © 2018 orange. All rights reserved.
//

import UIKit
//import StoreKit
class ViewController: UIViewController {
    let dateFormatter : DateFormatter = DateFormatter()
  
    let date = Date()
  
    @IBOutlet weak var nowtime: UILabel!
    
    
    @IBAction func drink(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      dateFormatter.dateFormat = "yyyy-MMM-dd"
      nowtime.text = dateFormatter.string(from: date)
       
        
      
        
    }


}

