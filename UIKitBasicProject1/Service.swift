//
//  Service.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 30/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import Foundation

class Service {
    fileprivate var baseUrl = ""
    typealias usersCallBack = (_ users:[user]?, _ status: Bool, _ message: String )->Void
    var callBack: usersCallBack?
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    
    func fetchUserJSON(completion: @escaping([user]?,Error?)->()){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            if let err = error {
                completion(nil,err)
                return
            }
            do {
                let  users = try JSONDecoder().decode([user].self, from: data!)
                completion(users,nil)
                
            }
                
            catch let jsonError{
                completion(nil,jsonError)
            }
            
        } .resume()
        
    }
}

