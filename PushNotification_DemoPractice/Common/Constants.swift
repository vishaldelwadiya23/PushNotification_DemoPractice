//
//  Constants.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 20/09/22.
//

import Foundation

class Constant {
    
    // API
    static func apiWithAlbumsDisplay(itemShow: Int) -> String {
        let api = String(format: "https://rss.applemarketingtools.com/api/v2/in/music/most-played/%d/albums.json", itemShow)
        return api
    }
    
    //static let BASEAPI = String(format: "https://rss.applemarketingtools.com/api/v2/in/music/most-played/%d/albums.json", apiTotalAlbumsCount)
    //static var apiTotalAlbumsCount = 50

    // Identifier
    static let ScrollReloadCellIdentifier = "ScrollReloadTableCell"
    static let MainStoryboard = ""
    static let MoreVCStoryboard = "MoreVC"
    static let ReloadTableVCStoryboard = ""
    
    // Common PrintLog
    static func printLog(str: Any) {
        print(String(describing: str))
    }
}

