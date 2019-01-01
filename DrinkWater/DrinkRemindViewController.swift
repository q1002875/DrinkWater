//
//  DrinkRemindViewController.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/8.
//  Copyright © 2018 orange. All rights reserved.
//

import UIKit
import CoreData

import UserNotifications
class DrinkRemindViewController: UIViewController,SetTimeViewControllerdelegate,UITableViewDelegate,UITableViewDataSource,RemindCelldelegate {
    
    
    var cellremind:DrinkModel!
    let defaults = UserDefaults.standard
    var data:[DrinkModel] = []
    func didcousmtswitch(cell: RemindCell) {
        if let indexpath = tableview.indexPath(for: cell){
            self.data[indexpath.row].switc = cell.Remid.isOn as NSNumber
        }
        
    }
    @IBOutlet weak var tableview: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RemindCell
        //位置
        
        cell.remindtime = data[indexPath.row]
        data[indexPath.row].switc = cell.remindtime.switc
        let product = data[indexPath.row]
        cell.setProduct(drink: product)
        self.didfinishupdata(note:cell.remindtime)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func add(_ sender: Any) {
        
        let moc = CoreDataHelper.shared.managedObjectContext()
        let water = DrinkModel(context: moc)
        water.drinktime = "新增提醒"
        data.insert(water, at: 0)
        let indexpath = IndexPath(row: 0, section: 0)
     
        water.switc = true
        savetodata()
       tableview.insertRows(at: [indexpath], with: .automatic)
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableview.setEditing(editing, animated: animated)
        
        
    }
    
    //要再修改
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if let currentkey = data[indexPath.row].drinktime{
                UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
                    var identifiers: [String] = []
                    for notification:UNNotificationRequest in notificationRequests {
                        if notification.identifier == currentkey{
                            identifiers.append(notification.identifier)
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
                            
                        }
                    }
                }
            }
            let note = data.remove(at: indexPath.row)
            CoreDataHelper.shared.managedObjectContext().delete(note)
 
           
            savetodata()
         
            tableview.deleteRows(at: [indexPath], with: .automatic)
     
        }
      
    }
    
    func savetodata(){
        CoreDataHelper.shared.saveContext()
        
    }
    func loadfromdata(){
        let moc = CoreDataHelper.shared.managedObjectContext()
        
        let fetch = NSFetchRequest<DrinkModel>(entityName: "Water")
        
        moc.performAndWait {
            do{
                let result = try  moc.fetch(fetch)
                data = result
            }catch{
                print("error")
            }
            
        }
        
        
    }
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert: tableview.insertRows(at: [newIndexPath! as IndexPath], with: UITableView.RowAnimation.fade)
        case .Delete:  if indexPath != newIndexPath {
            tableview.deleteRows(at: [indexPath! as IndexPath], with: .fade)
//            tableview.insertRows(at: [newIndexPath! as IndexPath], with: .fade)
            }
        case .Update: tableview.reloadRows(at: [indexPath! as IndexPath], with: UITableView.RowAnimation.none)
        case .Move:  if indexPath != newIndexPath {
            tableview.deleteRows(at: [indexPath! as IndexPath], with: .fade)
            tableview.insertRows(at: [newIndexPath! as IndexPath], with: .fade)
            }
        }
    }
    public enum NSFetchedResultsChangeType : UInt {
        case Insert // 1
        case Delete // 2
        case Move   // 3
        case Update // 4
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show"{
            if let whater = segue.destination as? SetTimeViewController {
                //要傳到class裡面
                if let indexpath = tableview.indexPathForSelectedRow{
                    whater.currentTime = data[indexpath.row]
                    
                    whater.delegate = self
                    
                }
                
            }
            
        }
        
        
    }
    
    func didfinishupdata(note:DrinkModel){
        if let index =  data.firstIndex(of: note){
            
            let indexpath = IndexPath(row: index, section: 0)
            
            savetodata()
           tableview.reloadRows(at: [indexpath], with: .automatic)
           
        }
        
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.reloadData()
        loadfromdata()
        navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    
}


