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
    var date = Date()
    let dateFormatter : DateFormatter = DateFormatter()
    
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var drinkprogress: UILabel!
    @IBOutlet weak var nowtime: UILabel!
    let defaults = UserDefaults.standard
    var count = 0
    
    var pcount: Float = 0
    @IBAction func drink(_ sender: Any) {
        
        count += 200
        
        let water = [dateFormatter.string(from: date): count]
        
        //會覆蓋掉前天的紀錄
        defaults.setValue(water, forKey: dateFormatter.string(from: date))
        //       saveLoginData(fromPropertyListvalue: datee,datakey: "mydatadatee.plist")
        //每次增加的量
        print(dateFormatter.string(from: date))
        
        //設定容量
        if count > 1800{
            count = 1800
            self.drinkprogress.text = "今日飲水已足夠"
        }else{
            self.drinkprogress.text = "現階段喝水\(count)cc"
        }
        
        pcount += 0.1
        progress.setProgress(pcount, animated: true)
        
        self.view.addSubview(progress)
        
    }
    func loadfromdata(){
          dateFormatter.dateFormat = "yyyy/MM/dd"
        let date =  defaults.dictionary(forKey: dateFormatter.string(from: self.date))
        
        for item in date ?? ["":0]{
            
            self.count = item.value as! Int
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadfromdata()
        
        dateFormatter.dateFormat = "yyyy/MM/dd"
        nowtime.text = dateFormatter.string(from: date)
        
        if count == 2000{
            drinkprogress.text = "今日飲水已足夠"
        }else if count == 0{
            drinkprogress.text = "今日尚無紀錄喝水"
        }else{
            drinkprogress.text = "現階段喝水\(count)cc"
        }
        
        
    }
    
}


