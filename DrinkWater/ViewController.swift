//
//  ViewController.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/8.
//  Copyright © 2018 orange. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var progressRing: CircularProgressBar!
    
    var date = Date()
    let dateFormatter : DateFormatter = DateFormatter()
    
    @IBOutlet weak var drinkprogress: UILabel!
    @IBOutlet weak var nowtime: UILabel!
    let defaults = UserDefaults.standard
    var count = 0.0
    var pcount: Float = 0
    var water : [String:Double]?
    override func viewDidLoad() {
        super.viewDidLoad()
        water = [dateFormatter.string(from:date): count]
        loadfromdata()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        nowtime.text = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if count == 2000{
            drinkprogress.text = "今日飲水已足夠"
        }else if count == 0{
            drinkprogress.text = "今日尚無紀錄喝水"
        }else{
            drinkprogress.text = "現階段喝水[\(Int(count))c.c]"
        }
        
        let xPosition = view.center.x
        let yPosition = view.center.y
        let position = CGPoint(x: xPosition , y: yPosition + 20 )
        
        progressRing = CircularProgressBar(radius: 100, position: position, innerTrackColor: .defaultInnerColor, outerTrackColor: .defaultOuterColor, lineWidth: 20)
        view.layer.addSublayer(progressRing)
        progressRing.progress = CGFloat(count)
       
        if self.count >= 2000 {
            let alert = UIAlertController(title: "恭喜達成今日2000c.c目標", message: "繼續保持歐", preferredStyle:.alert)
            let sure = UIAlertAction(title: "確認", style: .default)
            alert.addAction(sure)
            print("123123123")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func drink(_ sender: Any) {
        DrinkHowMany()
  
    }
    
  
    func DrinkHowMany(){
         loadfromdata()
        let alert = UIAlertController(title: "請選擇當次飲用容量", message: "人一天需攝取2000c.c水分為當日(100%)", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        alert.addAction(alertfunc(title: "100c.c      當日(5%)", counts: 100, imagename: "icons8-water-48"))
        alert.addAction(alertfunc(title: "200c.c      當日(10%)", counts: 200, imagename: "icons8-water-48"))
        alert.addAction(alertfunc(title: "300c.c      當日(15%)", counts: 300, imagename: "icons8-water-48"))
        alert.addAction(alertfunc(title: "400c.c      當日(20%)", counts: 400, imagename: "icons8-water-48"))
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
      
    }
    
    func alertfunc(title:String,counts:Double,imagename:String ) ->UIAlertAction{
        
        let drinkwater = UIAlertAction(title: title, style: .default) { (UIAlertAction) in
            self.count += counts
            self.progressRing.progress = CGFloat(self.count)
         
           self.water = [self.dateFormatter.string(from: self.date): self.count]
            
            self.defaults.setValue(self.water, forKey: self.dateFormatter.string(from: self.date))
            
            if self.count <= 2000{
                  self.drinkprogress.text = "現階段喝水[\(Int(self.count))c.c]"
                
            }else{
                  self.drinkprogress.text = "今日飲水\(Int(self.count))c.c已足夠"
            }

        }
        drinkwater.setValue(UIImage(named:imagename), forKey: "image")
      
        if self.count >= 2000 {
            let alert = UIAlertController(title: "恭喜達成今日2000c.c目標", message: "繼續保持歐", preferredStyle:.alert)
            let sure = UIAlertAction(title: "確認", style: .default)
            alert.addAction(sure)
            self.present(alert, animated: true, completion: nil)
        }
        
        return drinkwater
    }
    
    
    @IBAction func cowater(_ sender: Any) {
        let alert = UIAlertController(title: "刪除當日飲水紀錄", message: "請確認要刪除的c.c數", preferredStyle: .alert)
        let deleteOnehunder = UIAlertAction(title: "刪除飲水100c.c", style: .destructive) { (UIAlertAction) in
            self.count -= 100
            self.progressRing.progress = CGFloat(self.count)
            
            if self.count <= 0 {
                self.count = 0
            }
            
            self.water = [self.dateFormatter.string(from: self.date): self.count]
            self.defaults.setValue(self.water, forKey: self.dateFormatter.string(from: self.date))
            self.drinkprogress.text = "現階段喝水[\(Int(self.count))cc]"
        }
        let deleteTwohunder = UIAlertAction(title: "刪除飲水200c.c", style: .destructive) { (UIAlertAction) in
            self.count -= 200
            self.progressRing.progress = CGFloat(self.count)
            
            if self.count <= 0 {
                self.count = 0
            }
            
            self.water = [self.dateFormatter.string(from: self.date): self.count]
            self.defaults.setValue(self.water, forKey: self.dateFormatter.string(from: self.date))
            self.drinkprogress.text = "現階段喝水[\(Int(self.count))cc]"
        }
        let deleteZero = UIAlertAction(title: "飲水c.c數歸零", style: .destructive) { (UIAlertAction) in
            self.count = 0
            self.progressRing.progress = CGFloat(self.count)
            
            if self.count <= 0 {
                self.count = 0
            }
            
            self.water = [self.dateFormatter.string(from: self.date): self.count]
            self.defaults.setValue(self.water, forKey: self.dateFormatter.string(from: self.date))
            self.drinkprogress.text = "現階段喝水[\(Int(self.count))c.c]"
            
            
        }
         let cancel = UIAlertAction(title: "cancel", style: .default, handler: nil)
        alert.addAction(deleteOnehunder)
        alert.addAction(deleteTwohunder)
        alert.addAction(deleteZero)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func loadfromdata(){
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date =  defaults.dictionary(forKey: dateFormatter.string(from: self.date))
        
        for item in date ?? ["":0]{
            
            self.count = Double(item.value as! Int)
        }
    }
    
}

extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor.init(red: red / 225, green: green / 225, blue: blue / 225, alpha: 1)
    }
    static let defaultOuterColor = UIColor.rgb(225, 225, 225)
    static let defaultInnerColor: UIColor = .rgb(20, 20, 165)
    static let defaultPulseFillColor = UIColor.rgb(86, 30, 63)
}
