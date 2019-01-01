//
//  MoreViewController.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/27.
//  Copyright © 2018 orange. All rights reserved.
//

import UIKit
import MessageUI
class MoreViewController: UIViewController {
    let moreArray = ["意見&反饋","我要評分","當前版本:1.0"]
    let datasourceArray = ["政府資料開放平臺"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          navigationController?.navigationBar.isHidden = true
        
    }
    
}
extension MoreViewController:UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0{
            if indexPath.row == 0{
                if ( MFMailComposeViewController.canSendMail()){
                    let alert = UIAlertController(title: "", message: "歡迎使用e-mail給我意見及反饋", preferredStyle: .alert)
                    let email = UIAlertAction(title: "email", style: .default, handler: { (action) -> Void in
                        let mailController =  MFMailComposeViewController()
                        mailController.mailComposeDelegate = self
                        mailController.title = "意見&反饋"
                        mailController.setSubject("意見&反饋")
                        //取得forInfoDictionaryKey裡的資訊
                        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
                        let product = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")
                        let messageBody = "<br/><br/><br/>Product:\(product!)(\(version!))"
                        //寄件人
                        mailController.setMessageBody(messageBody, isHTML: true)
                        
                        //收件人可以是多個
                        mailController.setToRecipients(["q1002875@gmail.com"])
                        self.present(mailController, animated: true, completion: nil)
                    })
                    
                    let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
                    alert.addAction(email)
                    alert.addAction(cancel)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    //alert user can't send email
                }
            }
            if indexPath.row == 1{
                
                let appleID = "1448202495"
                let appURL = URL(string: "https://itunes.apple.com/us/app/itunes-u/id\(appleID)?action=write-review")
                UIApplication.shared.open(appURL!, options: [:]) { (success) in
                
                }
                
            }
            
            
        }else{
            if indexPath.section == 1 && indexPath.row == 0{
                let dataURL = URL(string: "https://data.gov.tw/dataset/67615")
                UIApplication.shared.open(dataURL!, options: [:]) { (success) in

                }

            }
    
        }
        

        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch (result){
        case MFMailComposeResult.cancelled:
            print("user cancelled")
        case MFMailComposeResult.failed:
            print("user failed")
        case MFMailComposeResult.saved:
            print("user saved email")
        case MFMailComposeResult.sent:
            print("email sent")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return moreArray.count
        }else{
            return datasourceArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.section == 0{
            cell.textLabel?.text = moreArray[indexPath.row]
        }else{
            cell.textLabel?.text = datasourceArray[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            return "關於"
        }else{
            return "資料來源"
        }
    }
    
    
    
    
}
