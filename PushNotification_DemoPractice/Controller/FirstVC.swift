//
//  FirstVC.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 21/09/22.
//

import UIKit

class FirstVC: UIViewController {

    @IBOutlet weak var lblMessage: UILabel!
    var strText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // notification click to display message pass by HomeVC
        lblMessage.text = strText
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
