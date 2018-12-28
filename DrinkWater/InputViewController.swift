//
//  InputViewController.swift
//  DelegatePractice
//
//  Created by Michael on 2018/12/17.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

protocol InputViewControllerDelegate {
    func didSend(text:String)
}


class InputViewController: UIViewController {
    
    var delegate:InputViewControllerDelegate?
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func done(_ sender: Any) {
        delegate?.didSend(text: inputField.text!)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification , object: nil, queue: nil, using: { (noti) in
            print("============",noti)
        })

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
