//
//  SetTimeViewController.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/9.
//  Copyright © 2018 orange. All rights reserved.
//

import UIKit

protocol SetTimeViewControllerdelegate:class {
    func didfinishupdata(note:DrinkModel)
}
class SetTimeViewController: UIViewController {

   weak var delegate :SetTimeViewControllerdelegate?
    var currentTime : DrinkModel!
    @IBOutlet weak var pickdate: UIDatePicker!
   
    @IBAction func done(_ sender: Any) {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        currentTime?.drinktime = format.string(from: pickdate.date)
        
        self.delegate?.didfinishupdata(note: currentTime)
          navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
pickdate.datePickerMode = .time
  
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
