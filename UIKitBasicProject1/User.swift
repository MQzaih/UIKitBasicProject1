//
//  User.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 27/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import Foundation

struct user {
    var fullName :String
    var username :String
    var phone:Int
    var emailAddress :String
    var website :String
    var img : String
    init(fullName: String, username: String, phone:Int,emailAddress:String, website:String, img:String){
        self.fullName = fullName
        self.username = username
        self.phone = phone
        self.emailAddress = emailAddress
        self.website = website
        self.img = img
    }
    
}
