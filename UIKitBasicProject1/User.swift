//
//  User.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 27/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import Foundation

struct user: Codable,Equatable {
    static func == (lhs: user, rhs: user) -> Bool {
        if lhs.name == rhs.name{
            return true
        }
        return false
    }
    
    var name  = " "
    var username  = " "
    var phone = ""
    var email  = ""
    var website = ""
    var address: Address?
    var company: Company?
    
    init(fullName: String, username: String, phone:String,emailAddress:String, website:String,address: Address? = nil, company:Company? = nil){
        self.name = fullName
        self.username = username
        self.phone = phone
        self.email = emailAddress
        self.website = website
        self.address = address
        self.company = company
    }

    
}

struct Company: Codable{
    var name: String
    var catchPhrase: String
    var bs: String
}

struct Address: Codable{
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
}

struct Geo: Codable{
    var lat: String
    var lng: String
}
