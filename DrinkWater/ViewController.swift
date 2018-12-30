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
    
  
    var progressRing: CircularProgressBar!
    
    var date = Date()
    let dateFormatter : DateFormatter = DateFormatter()
    
//    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var drinkprogress: UILabel!
    @IBOutlet weak var nowtime: UILabel!
    let defaults = UserDefaults.standard
    var count = 0.0
    
    var pcount: Float = 0
    @IBAction func drink(_ sender: Any) {
  
        
        count += 200
        
        progressRing.progress = CGFloat(count)
        if count >= 1800 {
            //            timer.invalidate()
        }
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
        
    }
    
    
    @IBAction func cowater(_ sender: Any) {
        count -= 200
        progressRing.progress = CGFloat(count)
        
        
        if count <= 200 {
            count = 0
        }
            self.drinkprogress.text = "現階段喝水\(count)cc"
        let water = [dateFormatter.string(from: date): count]
        
        //會覆蓋掉前天的紀錄
        defaults.setValue(water, forKey: dateFormatter.string(from: date))
    }
    
    func loadfromdata(){
          dateFormatter.dateFormat = "yyyy/MM/dd"
        let date =  defaults.dictionary(forKey: dateFormatter.string(from: self.date))
        
        for item in date ?? ["":0]{
            
            self.count = Double(item.value as! Int)
        }
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadfromdata()
//        navigationController?.navigationBar.isHidden = true
        dateFormatter.dateFormat = "yyyy/MM/dd"
        nowtime.text = dateFormatter.string(from: date)
        
        if count == 2000{
            drinkprogress.text = "今日飲水已足夠"
        }else if count == 0{
            drinkprogress.text = "今日尚無紀錄喝水"
        }else{
            drinkprogress.text = "現階段喝水\(count)cc"
        }
        
        
        
        let xPosition = view.center.x
        let yPosition = view.center.y
        let position = CGPoint(x: xPosition , y: yPosition - 60 )
        
        progressRing = CircularProgressBar(radius: 100, position: position, innerTrackColor: .defaultInnerColor, outerTrackColor: .defaultOuterColor, lineWidth: 20)
        view.layer.addSublayer(progressRing)
        
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
