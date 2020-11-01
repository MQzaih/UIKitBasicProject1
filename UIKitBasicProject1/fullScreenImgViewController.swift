//
//  fullScreenImgViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 30/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit

class fullScreenImgViewController: UIViewController {

    @IBOutlet weak var imgFullScreen: UIImageView!
    var img : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgFullScreen.image = img
    }
    

    

}
