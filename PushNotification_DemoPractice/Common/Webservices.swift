//
//  Webservices.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 23/09/22.
//

import Foundation

class Webservices {
    
    static func getTopAlbumsApi(url: URL, completionHandlar: @escaping(TopAlbumsModel) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (responseData, httpResponse, error) in
            if error == nil && responseData != nil && responseData?.count != 0 {
                do {
                    let userResponse = try JSONDecoder().decode(TopAlbumsModel.self, from: responseData!)
                    //print(userResponse)
                    completionHandlar(userResponse)
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}
