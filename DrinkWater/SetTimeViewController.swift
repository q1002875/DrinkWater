//
//  SetTimeViewController.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/9.
//  Copyright © 2018 orange. All rights reserved.
//

import UIKit
import UserNotifications
struct CellData {
    var isopen:Bool
    var sectionTitle:String
    var sectionData:[String]

}
protocol SetTimeViewControllerdelegate:class {
    func didfinishupdata(note:DrinkModel)
    
}

class SetTimeViewController: UIViewController {
    var tableViewData = [CellData]()
    @IBOutlet weak var tableview: UITableView!
    weak var delegate :SetTimeViewControllerdelegate?
    var currentTime : DrinkModel!
    let app = UIApplication.shared.delegate as! AppDelegate
    var center: UNUserNotificationCenter?
    @IBOutlet weak var pickdate: UIDatePicker!
     let defaults = UserDefaults.standard
    //顯示提醒後的通知匡
    let snoozeAction = UNNotificationAction(identifier: "SnoozeAction",
                                            title: "延遲一分鐘", options: [.authenticationRequired])
    let deleteAction = UNNotificationAction(identifier: "DeleteAction",
                                            title: "刪除", options: [.destructive])
    
    
    @IBAction func done(_ sender: Any){
        center?.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                self.sendNotification()
            }else if settings.authorizationStatus == .denied {
                self.deniedAlert()
            }else { return }
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickdate.datePickerMode = .time
        let category = UNNotificationCategory(identifier: "DemoNotificationCategory",
                                              actions: [snoozeAction,deleteAction],
                                              intentIdentifiers: [], options: [])
        center = app.center
        center?.setNotificationCategories([category])
       
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = UITableView.automaticDimension
        
        tableViewData = [CellData(isopen: false, sectionTitle: "☀️早上5點~7點", sectionData: ["利用這時「大腸經」值班的時間，空腹先喝一杯水，有利腸胃蠕動，將累積一夜的毒素、廢物通通帶出體外。"]),
                         CellData(isopen: false, sectionTitle: "💼早上9點", sectionData: ["一到公司、學校第一件事別再是「沖杯咖啡」、「插下飲料吸管」了！先來上一杯溫水，有助於平穩匆忙的心情，有助提高工作、學習效率，同時記得將水杯乘好水，放在桌子前，提醒自己隨時都要記得補充水分。"]),
                         CellData(isopen: false, sectionTitle: "🍽中午飯後半小時（約下午1點）", sectionData: ["飯後半小時補充一杯水，有助於胃消化食物，同時能加速血液循環，對於「排毒」有事半功倍的效果！但記住，程涵宇營養師提醒各位：「飯後不建議立刻喝水，因為會沖淡胃液，使蛋白酶的活性減低，反而會影響到消化作用！」"]),
                         CellData(isopen: false, sectionTitle: "🌈下午3點~5點", sectionData: ["這時是「膀胱經」當班，也是新陳代謝最快的時候，多喝1~2杯水，等於是給身體下場大雨，能帶動體內的大循環，利用「排尿」就能將累積於體內的廢物毒素排出！此時不僅是排毒、減肥最佳時機，也是你和大肚肥油說掰掰的好時機，千萬要好好把握喔！"]),
                         CellData(isopen: false, sectionTitle: "🍜晚餐前半小時（約晚上6點)", sectionData: ["晚餐不要吃太飽，所以建議在晚餐前補充1杯水，會有飽足感、能降低食慾。且也有利於溶解晚餐攝取的「鹽分」，畢竟晚餐離睡眠時間比較進，過多的鹽分若來不及消化吸收，易造成水腫，也會造成身體的負擔。"]),
                         CellData(isopen: false, sectionTitle: "😴睡前喝一「小」杯水", sectionData: ["晚餐後新陳代謝較慢不建議喝水，易造成腎臟負擔及水腫，且也可能因為「夜尿」而影響睡眠品質。但因為睡眠時間長，這段期間身體會缺水，使血流較慢、血較濃稠，容易誘發心血管疾病，所以建議在睡前補充一小杯水，約50~80cc即可。"])]
    }
    
    func sendNotification(){
        DispatchQueue.main.async {
            let format = DateFormatter()
            format.dateFormat = "HH:mm"
            self.currentTime?.drinktime = format.string(from: self.pickdate.date)
            //        print(currentTime.drinktime)
            let content = UNMutableNotificationContent()
            content.title = "補充水分的時間到囉!!!"
            content.body = ""
            content.sound = UNNotificationSound.default
//            content.badge = NSNumber(integerLiteral: UIApplication.shared.applicationIconBadgeNumber + 1)
            content.launchImageName = ""
            content.categoryIdentifier = "DemoNotificationCategory"
            let uuid = UUID().uuidString
            let date = self.pickdate.date
            let triggerDate = Calendar.current.dateComponents([ .hour, .minute,], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            let request = UNNotificationRequest(identifier:format.string(from: self.pickdate.date), content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            //        currentTime.saveuuid = uuid
            let diction = [uuid:""]
            
            self.defaults.setValue(diction, forKey:"UUU")
            
            self.delegate?.didfinishupdata(note: self.currentTime)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    func deniedAlert() {
        let useNotificationsAlertController = UIAlertController(title: "打開提醒", message: "提醒喝水需要打開您的提醒通知 \n ", preferredStyle: .alert)
        
        // go to setting alert action
        let goToSettingsAction = UIAlertAction(title: "設定", style: .default, handler: { (action) in
            guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingURL) {
                UIApplication.shared.open(settingURL, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        })
        let cancelAction = UIAlertAction(title: "取消", style: .default)
        useNotificationsAlertController.addAction(goToSettingsAction)
        useNotificationsAlertController.addAction(cancelAction)
        
        self.present(useNotificationsAlertController, animated: true)
    }
        
    }
    

extension SetTimeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].isopen == true{
            
            return tableViewData[section].sectionData.count+1
            
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "title",for:indexPath)
            cell.textLabel?.text = tableViewData[indexPath.section].sectionTitle
         
            return cell
        }else{
            let cell =  tableView.dequeueReusableCell(withIdentifier: "item",for:indexPath)
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 6
            cell.textLabel?.text =  tableViewData[indexPath.section].sectionData[indexPath.row-1]
            
            return cell
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
     
            if   tableViewData[indexPath.section].isopen == true{
                tableViewData[indexPath.section].isopen = false
                let indexes =  IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
                
            }else{
                tableViewData[indexPath.section].isopen = true
                let indexes =  IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
                
            }
            
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
    
   
    

    

    
    
    
    
    
    
}
