//
//  Webservices.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 23/09/22.
//

import Foundation
import Alamofire
import SystemConfiguration

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
    
    /*class func callApi(_ url: String, param: [String: Any]?, type: HTTPMethod, header: HTTPHeaders?, callSilently: Bool = false, successBlock success: @escaping (_ responseDict: NSDictionary?, _ responseArray: NSArray?) -> Void, failureBlock failure: @escaping (_ error: Error?, _ isTimeOut: Bool) -> Void) {
        
        let urlWithUTF8 = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        AF.request(urlWithUTF8!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers:nil).responseDecodable(of: TopAlbumsModel.self) { (response) in
            
            switch response.result {
                case .success(let dTypes):
                    print(dTypes.feed)
                    success(dTypes.feed)
                case .failure(let error):
                    print(error)
            }
        }
    }*/
}

class MWebServices: NSObject {
    
    //MARK: - Check Internet
    class func isNetworkAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
        

    //MARK: - Services Calling ===========/POST REQUEST/====================
    /*class func callPOSTRequestAPI<T:Decodable>(_ url: String,
                       param: [String: Any]?,
                       type : HTTPMethod,
                       header : HTTPHeaders?,
                       resultType: T.Type,
                       callSilently : Bool = false,
                       successBlock: @escaping (_ result: T?, _ statusCode: Int?) -> Void,
                       failureBlock: @escaping (_ error: Error?) -> Void) {
        
        if isNetworkAvailable() {
            let urlWithUTF8 =  url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
                        
            AF.request(url, method: type, parameters: param, encoding: JSONEncoding.default, headers: header).responseDecodable(of: T.self) { (response) in
                
                if let data = response.data {
                    //Constants.printLog(str:"Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                    //Constant.printLog(str: String(data: data, encoding: String.Encoding.utf8) ?? "")
                }
                //Constant.printLog(str:"---- REQUEST URL RESPONSE : \(urlWithUTF8!)\n\(response.result)")
                
                switch response.result {
                case let .success(value):
                    if ((value as T) != nil) {
                        successBlock(value, Int(response.response!.statusCode))
                    } else {
                        failureBlock(nil)
                    }
                case .failure(let error):
                    if (error as NSError).code == -1001 {
                        Constant.printLog(str:"Progress")
                        // The request timed out error occured. // Code=-1001 "The request timed out."
                    } else {
                        failureBlock(error)
                        Constant.printLog(str:"Progress")
                    }
                    break
                }
            }
        } else {
            Constant.printLog(str:"Progress")
        }
    }*/
    
    //MARK: - Services Calling ===========/GET REQUEST/====================
    class func callRequestAPI<T:Decodable>(_ url: String,
                       type : HTTPMethod,
                       header : HTTPHeaders?,
                       param: [String: Any]?,
                       resultType: T.Type,
                       successBlock: @escaping (_ result: T?) -> Void,
                       failureBlock: @escaping (_ error: Error?) -> Void) {
        
        if isNetworkAvailable() {
            let urlWithUTF8 =  url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
                        
            AF.request(url, method: type, parameters: param, encoding: JSONEncoding.default, headers: header).responseDecodable(of: resultType.self) { (response) in
                
                if let data = response.data {
                    //Constants.printLog(str:"Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                    //Constant.printLog(str: String(data: data, encoding: String.Encoding.utf8) ?? "")

                }
                //Constant.printLog(str:"---- REQUEST URL RESPONSE : \(urlWithUTF8!)\n\(response.result)")
                
                switch response.result {
                case let .success(value):
                    successBlock(value)
                case .failure(let error):
                    if (error as NSError).code == -1001 {
                        Constant.printLog(str:"Progress")
                        // The request timed out error occured. // Code=-1001 "The request timed out."
                    } else {
                        failureBlock(error)
                        Constant.printLog(str:"Progress")
                    }
                    break
                }
            }
        } else {
            Constant.printLog(str:"Progress")
        }
    }
}
