//
//  AddProfileViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 29/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit

class AddProfileViewController: UIViewController,UITextFieldDelegate {
    
    var name = ""
    var email = ""
    var website = ""
    var username = ""
    var phone = ""
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var websiteText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    let userDefaults = [user]()
    @IBOutlet weak var warning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameText.delegate = self
        
       // if let value = userDefaults.value(forKey: "name") as? String {
          //  warning.text = value
        }
        
        // Do any additional setup after loading the view.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameText.resignFirstResponder()
        return true
    }

}
