//
//  Album.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 31/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import Foundation
struct Album {
    var id = 0
    var num = 0
    var imgs = [Photo]()
    
   mutating func addImg(image:Photo){
        imgs.append(image)
    }
}
