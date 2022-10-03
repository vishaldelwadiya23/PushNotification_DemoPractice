//
//  ThirdVC.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 22/09/22.
//

import UIKit

class ThirdVC: UIViewController {

    var aryResult: [Result] = [Result]()
    var aryDisplayMore: [Result] = [Result]()
    
    let topAlbumViewModel: TopAlbumViewModel = TopAlbumViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let strUrl = Constant.BASEAPI
        let url = URL(string: strUrl)
        
        //getApiData(url: url!)
        
        postApiData(url: url!)
    }

    // CodeCat Api Example
    //MARK: - JSONSerialization GET Method Use
    // read data using json serialization using url session (old fashion passing)
    func getApiData(url: URL) {
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (serviceData, serviceResponse, error) in
            
            if error == nil {
                let httpResponse = serviceResponse as! HTTPURLResponse
                
                print(httpResponse.statusCode)
                // 200 means success result
                if httpResponse.statusCode == 200 {
                    
                    let jsonData = try? JSONSerialization.jsonObject(with: serviceData!, options: .mutableContainers)
                    print(jsonData)
                }
            }
        }
        task.resume()
    }

    //MARK: - JSONSerialization POST Method & URLRequest using get method
    func postApiData(url: URL) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        
        //let dict = ["userId":"1","password":"1234"]
        //let requestBody = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        //request.httpBody = requestBody
        //request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if (error == nil && data != nil && data?.count != 0) {
                
                let result = String(data: data!, encoding: .utf8)
                debugPrint(result!)
            }
        }.resume()
    }

}
