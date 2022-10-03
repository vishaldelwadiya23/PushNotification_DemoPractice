//
//  HttpUtility.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 30/09/22.
//

import Foundation

struct HttpUtility {
    
    // Singleton class method
    static let shared = HttpUtility()
    private init(){}
    
    // common get api request generic method
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping(_ result: T?) -> Void) {
        
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            
            if (error == nil && responseData != nil && responseData?.count != 0) {
                
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _ = completionHandler(result)
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    // common post api request generic method
    func postApiData<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler: @escaping (_ result: T?) -> Void) {
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "post"
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
            
            if (error == nil && responseData != nil && responseData?.count != 0) {
                
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _ = completionHandler(result)
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
