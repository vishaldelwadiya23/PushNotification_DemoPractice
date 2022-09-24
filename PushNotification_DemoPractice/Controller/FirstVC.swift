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
    
    // Outlet for notification
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // local notification click to display message pass by HomeVC
        lblMessage.text = strText
        
        // pass data using notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(foodNotification(notification:)), name: .food, object: nil)
    }
    
    // notification method
    @objc func foodNotification(notification: Notification) {
        //lblFoodTitle.text = "egg food title"
        imgFood.image = #imageLiteral(resourceName: "Egg-2")
        
        //get dictionary to second vc
        let name = notification.userInfo!["name"] as? [String]
        lblFoodTitle.text = name![0]
    }
    
    // move to second vc
    @IBAction func btnMoveToSecondVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreVC", bundle: nil)
        if #available(iOS 13.0, *) {
            
            // use storyboard extension to navigate
            //let sv = UIStoryboard.storyboardNavigation(storyboard: "MoreVC", identifier: "SecondVC") as! SecondVC
            //self.navigationController?.pushViewController(sv, animated: true)
            
            let secondVC = storyboard.instantiateViewController(identifier: "SecondVC") as! SecondVC
            self.navigationController?.pushViewController(secondVC, animated: true)
        } else {
            // Fallback on earlier versions
        }
    }
}

extension Notification.Name {
    static let food = Notification.Name("foodImg")
}
