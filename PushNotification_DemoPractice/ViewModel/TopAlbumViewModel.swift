//
//  TopAlbumViewModel.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 30/09/22.
//

import Foundation

struct TopAlbumViewModel {
    
    func getAlbums(url: URL, completionHandler: @escaping(_ result: TopAlbumsModel?) -> Void) {
                
        //let strUrl = Constant.BASEAPI
        //print(strUrl)
        //let url = URL(string: strUrl)
        
        HttpUtility.shared.getApiData(requestUrl: url, resultType: TopAlbumsModel.self) { (topAlbumApiResponse) in
            
            _ = completionHandler(topAlbumApiResponse)
        }
    }
}
