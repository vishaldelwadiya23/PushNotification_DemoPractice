//
//  SecondVC.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 22/09/22.
//

import UIKit

class SecondVC: UIViewController {

    // Outlet
    @IBOutlet weak var lblFood: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // move data to previous VC
    @IBAction func btnMoveToPreviousFirstVC(_ sender: Any) {
        
        NotificationCenter.default.post(name: .food, object: nil)
        self.navigationController?.popViewController(animated: true)
    }

}
