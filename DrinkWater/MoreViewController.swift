//
//  MoreViewController.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/27.
//  Copyright © 2018 orange. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    



}
extension MoreViewController:UITableViewDataSource,UITableViewDelegate{


    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "123"
        
        return cell
    }


    
    

}
