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
        
        // pass user info in previous vc
        let dict = ["name" : ["Egg Food Image Show",lblFood.text]]
        
        NotificationCenter.default.post(name: .food, object: nil, userInfo: dict)
        self.navigationController?.popViewController(animated: true)
    }

}
