//
//  Service.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 30/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    fileprivate var baseUrl = ""
    typealias usersCallBack = (_ users:[user]?, _ status: Bool, _ message: String )->Void
    var callBack: usersCallBack?
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    func getUsers(){
        AF.request("https://jsonplaceholder.typicode.com/users", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response{
                  (responseData) in
                  guard let data = responseData.data else {
                      return
                  }
                  do {
                  let users = try JSONDecoder().decode([user].self, from: data)
                    self.callBack?(users,true,"")

                      print(users)
                    
                  }
                  catch {
                      print("ERROR decoding\(error)")
                    
                    
         self.callBack?(nil,false,error.localizedDescription)
                  }
              }
        
    }
    func completionHandler(callBack:@escaping usersCallBack){
        self.callBack = callBack
    }
}

