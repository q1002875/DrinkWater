////
////  change.swift
////  DrinkWater
////
////  Created by 徐志豪 on 2018/12/9.
////  Copyright © 2018 orange. All rights reserved.
////
//
//import Foundation
//class AddClockViewController {
//    @IBOutlet private weak var dataPicker: UIDatePicker!
//    @IBOutlet private weak var repeatLabel: UILabel!
//    @IBOutlet private weak var tagLabel: UILabel!
//    @IBOutlet private weak var musicLabel: UILabel!
//    @IBOutlet private weak var laterSwitch: UISwitch!
//    
//    func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Uncomment the following line to preserve selection between presentations.
//        // self.clearsSelectionOnViewWillAppear = NO;
//        
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//        
//        tableView.tableFooterView = UIView()
//        
//        dataPicker.setValue(UIColor.white, forKey: "textColor")
//        dataPicker.backgroundColor = UIColor.black
//        
//        or_reloadData()
//    }
//    
//    func awakeFromNib() {
//        super.awakeFromNib()
//        tableView.reloadData()
//    }
//    
//    func or_reloadData() {
//        
//        if model == nil {
//            model = ClockModel()
//        } else {
//            if let aDate = model?.date {
//                dataPicker.date = aDate
//            }
//            repeatLabel.text = model?.repeatStr
//            tagLabel.text = model?.tagStr
//            musicLabel.text = model?.music
//            laterSwitch.isOn = model?.isLater ?? false
//        }
//        
//        tableView.reloadData()
//    }
//    
//    //取消鍵
//    @IBAction func action_backBtn(_ sender: Any) {
//        dismiss(animated: true)
//    }
//    
//    //儲存件
//    @IBAction func action_saveBtn(_ sender: Any) {
//        
//        model.date = dataPicker.date
//        model?.music = musicLabel.text
//        model?.tagStr = tagLabel.text
//        model?.isLater = laterSwitch.isOn
//        //    _model.repeatStr = _repeatLabel.text;
//        model?.isOn = true
//        model?.isLater = laterSwitch.isOn
//        if block {
//            block(model)
//}
//        do {
//            
//            var baseVC = segue.destination as? BaseTableViewController
//            if (segue.identifier == "musicListVC") {
//                baseVC?.block = { text in
//                    self.model.music = text
//                    self.musicLabel.text = text
//                }
//                baseVC?.data = model.music
//            } else if (segue.identifier == "repeatVC") {
//                baseVC?.block = { repeats in
//                    self.model.repeatStrs = repeats
//                    self.repeatLabel.text = self.model.repeatStr
//                }
//                baseVC?.data = model.repeatStrs
//            } else if (segue.identifier == "labelVC") {
//                baseVC?.block = { text in
//                    self.model.tagStr = text
//                    self.tagLabel.text = text
//                }
//                baseVC?.data = model.tagStr
//            }
//            
//        }
//        
//        -
//        do {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//        
//        -
//        do {
//            model = model
//            or_reloadData()
//}
