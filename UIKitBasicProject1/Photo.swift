//
//  Photo.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 30/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import Foundation

struct Photo: Codable{
    var id = 0
    var url = ""
    var thumbnailUrl = ""
    var albumId = 0
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
        case albumId = "albumId"
    }
}

