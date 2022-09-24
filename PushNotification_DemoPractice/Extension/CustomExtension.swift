//
//  CustomExtension.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 20/09/22.
//

import Foundation
import UIKit

//MARK: - Data to Hex string
// use for push notification device token data to hex string
extension Data {
    var hexString: String {
        let hexStr = map {
            String(format: "%02.2hhx", $0)
        }.joined()
        return hexStr
    }
}

//MARK: - Storyboard extension
extension UIStoryboard {
    static func storyboardNavigation(storyboard: String, identifier: String) -> UIViewController {
        let sb = UIStoryboard(name: storyboard, bundle: Bundle.main)
        return sb.instantiateViewController(withIdentifier: identifier)
    }
}
