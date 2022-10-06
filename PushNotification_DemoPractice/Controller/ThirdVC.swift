//
//  ThirdVC.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 22/09/22.
//

import UIKit

struct Utility {
    
    func apiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping(_ result: T)->Void) {
        
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            
            if (error == nil && data != nil && data?.count != 0) {
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data!)
                    _ = completionHandler(result)
                    
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}

class ThirdVC: UIViewController {

    var aryResult: [Result] = [Result]()
    var aryDisplayMore: [Result] = [Result]()
    
    let topAlbumViewModel: TopAlbumViewModel = TopAlbumViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let strUrl = Constant.apiWithAlbumsDisplay(itemShow: 50)
        let urlWithItem = URL(string: strUrl)
        
        //getApiData(url: urlWithItem!)
        
        //postApiData(url: urlWithItem!)
        
        getData(url: urlWithItem!)
    }

    // CodeCat Api Example
    //MARK: - JSONSerialization GET Method Use
    // get data using json serialization using url session (old fashion passing)
    func getApiData(url: URL) {
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (serviceData, serviceResponse, error) in
            
            if error == nil {
                let httpResponse = serviceResponse as! HTTPURLResponse
                
                print(httpResponse.statusCode)
                // 200 means success result
                if httpResponse.statusCode == 200 {
                    let jsonData = try? JSONSerialization.jsonObject(with: serviceData!, options: .mutableContainers)
                    print(jsonData as Any)
                }
            }
        }
        task.resume()
    }

    //MARK: - JSONSerialization POST Method & URLRequest using get method
    func postApiData(url: URL) {
        
        // get and send data using json serialization
/*        var request = URLRequest(url: url)
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
*/
        
        // get data using json decodable protocol
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if (error == nil && data != nil && data?.count != 0) {
                do {
                    let jsonData = try JSONDecoder().decode(TopAlbumsModel.self, from: data!)
                    print(jsonData.feed.results)
                    
                } catch let err {
                    print(err)
                }
            }
        }.resume()
    }

    // get data using httputility common file
    func getData(url: URL) {
        
        let utility = Utility()
        utility.apiData(requestUrl: url, resultType: TopAlbumsModel.self) { (resultData) in
            
            if resultData.feed.results.count != 0 {
                print(resultData.feed.results)
            }
        }
    }
}
