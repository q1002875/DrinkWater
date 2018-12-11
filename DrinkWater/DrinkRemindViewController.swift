//
//  DrinkRemindViewController.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/8.
//  Copyright © 2018 orange. All rights reserved.
//

import UIKit
import CoreData
class DrinkRemindViewController: UIViewController,SetTimeViewControllerdelegate,UITableViewDelegate,UITableViewDataSource {

        var data:[DrinkModel] = []
        
    @IBOutlet weak var tableview: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RemindCell

            let product = data[indexPath.row]
            cell.setProduct(drink: product)
            return cell
            
        }
        
        
    @IBAction func add(_ sender: Any) {
        
        let moc = CoreDataHelper.shared.managedObjectContext()
        let water = DrinkModel(context: moc)
        water.drinktime = "New Time"
        data.insert(water, at: 0)
        let indexpath = IndexPath(row: 0, section: 0)
        tableview.insertRows(at: [indexpath], with: .automatic)
        savetodata()
    }
    
        
        override func setEditing(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: animated)
            self.tableview.setEditing(editing, animated: animated)
            
            
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            let note = data.remove(at: indexPath.row)
            CoreDataHelper.shared.managedObjectContext().delete(note)
            let indexpath = IndexPath(row:indexPath.row , section: 0)
            tableview.deleteRows(at: [indexpath], with: .automatic)
            savetodata()
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
                }catch{}
                
            }
            
            
        }
        
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "show"{
                if let whater = segue.destination as? SetTimeViewController {

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
                
                tableview.reloadRows(at: [indexpath], with: .automatic)
                savetodata()
            }
            
            
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loadfromdata()
            navigationItem.leftBarButtonItem = self.editButtonItem
        }
        
        
}


