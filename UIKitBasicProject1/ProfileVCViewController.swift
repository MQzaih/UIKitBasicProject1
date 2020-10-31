//
//  ProfileVCViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 27/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit

class ProfileVCViewController: UIViewController {
var name = ""
    var email = ""
    var username = " "
    var phone = ""
    var website = " "
    var img = " "
    @IBOutlet var userimg : UIImageView!
    @IBOutlet var emailLabel : UILabel!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var phoneLabel : UILabel!
    @IBOutlet var usernameLabel : UILabel!
    @IBOutlet var websiteLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLabel.text = email
        nameLabel.text = name
        phoneLabel.text = phone
        usernameLabel.text = username
        websiteLabel.text = website
        userimg.image = UIImage(named: img)
    }
    


}
