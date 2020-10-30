//
//  User.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 27/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import Foundation

struct user: Codable {
    var name :String = " "
    var username :String = " "
    var phone:String = ""
    var email :String = ""
    var website :String = ""
    init(fullName: String, username: String, phone:String,emailAddress:String, website:String){
        self.name = fullName
        self.username = username
        self.phone = phone
        self.email = emailAddress
        self.website = website
    }
    
 
}
