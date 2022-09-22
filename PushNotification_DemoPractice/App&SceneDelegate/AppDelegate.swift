//
//  AppDelegate.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 19/09/22.
//

import UIKit
//import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    //var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       /* if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            
            // If your app wasn’t running and the user launches it by tapping the push notification, the push notification is passed to your app in the launchOptions
            
            let aps = notification["aps"] as! [String: AnyObject]
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
        registerForPushNotifications(for: application) */
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//MARK: - Push notification Methods
/*extension AppDelegate {
    
    // register user notification
    func registerForPushNotifications(for application: UIApplication) {
    
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { (granted, error) in
                
                guard granted else {
                    print("Please enable \"Notifications\" from App Settings.")
                    self.showPermissionAlert()
                    return
                }
                self.getNotificationSettings()
            }
        } else {
            
            let setting = UIUserNotificationSettings(types: [.badge,.sound,.alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    // user decline permision then setting page to show permition method
    @available(iOS 10.0, *)
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        print("Notification settings: \(settings)")
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
    
    // device token get for push notification
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        //        let token = deviceToken.map {
//            String(format: "%02.2hhx", $0)
//        }.joined()
        // use extension
        let token = deviceToken.hexString
        print("Device Token: \(token)")
        //UserDefaults.standard.set(token, forKey: DEVICE_TOKEN)

        
    }
    
    // app running time receive notification
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if #available(iOS 14.0, *) {
            completionHandler([.badge,.sound,.banner])
        } else {
            // Fallback on earlier versions
        }
    }
    
    // user tapped on notification
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
//        defer {
//            completionHandler()
//        }
        completionHandler()
        print("user tapped push notification")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("i am not available in simulator : \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {

        // If your app was running and in the foreground
        // Or
        // If your app was running or suspended in the background and the user brings it to the foreground by tapping the push notification

        print("didReceiveRemoteNotification /(userInfo)")

        guard let dict = userInfo["aps"]  as? [String: Any], let msg = dict ["alert"] as? String else {
            print("Notification Parsing Error")
            return
        }
    }
    
    func showPermissionAlert() {
        let alert = UIAlertController(title: "WARNING", message: "Please enable access to Notifications in the Settings app.", preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) {[weak self] (alertAction) in
            self?.gotoAppSettings()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)

        alert.addAction(settingsAction)
        alert.addAction(cancelAction)

        DispatchQueue.main.async {
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    private func gotoAppSettings() {

        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.openURL(settingsUrl)
        }
    }
} */
