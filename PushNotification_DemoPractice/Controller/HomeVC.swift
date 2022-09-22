//
//  HomeVC.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 20/09/22.
//

import UIKit
import UserNotifications

@available(iOS 10.0, *)
class HomeVC: UIViewController, UNUserNotificationCenterDelegate {

    // current notification initialized
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // notification delegate set
        notificationCenter.delegate = self
        
        // notification authorization request to user
        notificationCenter.requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            
            guard granted else { return }
            
        }
        
        // Do any additional setup after loading the view.
    }
    

    // Press btn to show Local Notification
    @IBAction func btnLocalNotificationClicked(_ sender: Any) {
        
        // notification Content
        let content = UNMutableNotificationContent()
        content.title = "Local Notification"
        content.body = "This is local notificaion example"
        content.categoryIdentifier = "My Category Identifier"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        // UserInfo dict attech to notification
        content.userInfo = ["name" : "Vishal Delwadiya"]
        
        // content Image (image fetch in url format)
        let path = Bundle.main.path(forResource: "Egg-6", ofType: "jpg")
        if let path = path {
            let url = URL(fileURLWithPath: path)
            let attachment = try! UNNotificationAttachment.init(identifier: "image", url: url, options: [:])
            content.attachments = [attachment]
        }
        
        // notification Trigger
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        let identifier = "Main Identifier"
        
        // notification Request
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        
        // add request to notification center
        notificationCenter.add(request) { (error) in
            print("\(error?.localizedDescription)")
        }
        
        // notification Action
        let like = UNNotificationAction.init(identifier: "Like", title: "Like", options: .foreground)
        let delete = UNNotificationAction.init(identifier: "Delete", title: "Delete", options: .destructive)
        let category = UNNotificationCategory.init(identifier: content.categoryIdentifier, actions: [like,delete], intentIdentifiers: [], options: [])
        
        notificationCenter.setNotificationCategories([category])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if #available(iOS 13.0, *) {
            let firstVC = self.storyboard?.instantiateViewController(identifier: "FirstVC") as! FirstVC
            
            if let dict = response.notification.request.content.userInfo as? [AnyHashable:Any] {
                firstVC.strText = dict["name"] as! String
            }
            self.navigationController?.pushViewController(firstVC, animated: true)
            
        } else {
            // Fallback on earlier versions
        }
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
