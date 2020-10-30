//
//  GalleryServer.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 30/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//


import Foundation
import Alamofire

class GalleryServer {
    
    fileprivate var baseUrl = ""
    typealias photoCallBack = (_ photos:[Photo]?, _ status: Bool, _ message: String )->Void
    var callBack: photoCallBack?
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    func getPics(){
        AF.request(baseUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response{
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                self.callBack?(photos,true,"")
           //     print(photos)
            }
            catch {
                print("ERROR decoding\(error)")
                
                
                self.callBack?(nil,false,error.localizedDescription)
            }
        }
        
    }
    
    func completionHandler(callBack:@escaping photoCallBack){
        self.callBack = callBack
    }
    
    
}

