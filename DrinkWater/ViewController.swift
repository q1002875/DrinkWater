//
//  ViewController.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/8.
//  Copyright © 2018 orange. All rights reserved.
//

import UIKit
import CoreData

//import StoreKit
class ViewController: UIViewController {
    var date = Date()
    let dateFormatter : DateFormatter = DateFormatter()
    
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var drinkprogress: UILabel!
    @IBOutlet weak var nowtime: UILabel!
   
    var count = 0
   
    var pcount: Float = 0
    @IBAction func drink(_ sender: Any) {
       
        count += 200
        let datee = dateFormatter.string(from: date)

        var water = Dictionary<String,Any>()
        water [dateFormatter.string(from: date)] = count

       saveLoginData(fromPropertyListvalue: water,datakey:"mydata.plist" )
       saveLoginData(fromPropertyListvalue: datee,datakey: "mydatadatee.plist")
        //每次增加的量
        
        
        //設定容量
        if count > 1900{
            count = 1900
            self.drinkprogress.text = "今日飲水已足夠"
        }else{
            self.drinkprogress.text = "\(count)cc"
        }
        
        pcount += 0.1
        progress.setProgress(pcount, animated: true)
        
        self.view.addSubview(progress)
        
    }
    func loadfromdata(){
        do{
            let url = URL(fileURLWithPath: NSHomeDirectory())
            let fileurl = url.appendingPathComponent("mydata.plist")
            let data = try Data(contentsOf: fileurl)
            var format = PropertyListSerialization.PropertyListFormat.xml
            let date = try (PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: &format) as? [String:Int])
        
            for item in date! {
                self.count = item.value
            }
           
            
           }catch{
            print("error")
            
        }
        
    }
    func saveLoginData(fromPropertyListvalue:Any,datakey:String) {
        let url = URL(fileURLWithPath: NSHomeDirectory())
        let fileurl = url.appendingPathComponent(datakey)
        do {
            let datakey = try PropertyListSerialization.data(fromPropertyList: fromPropertyListvalue,format: .xml, options: 0)
            
            try datakey.write(to: fileurl)
            
        }catch{
            print("error")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadfromdata()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        nowtime.text = dateFormatter.string(from: date)
        
        if count == 2000{
             drinkprogress.text = "今日飲水已足夠"
        }else{
             drinkprogress.text = "今日尚無紀錄喝水"
        }
      
       
    }
    
}
    

