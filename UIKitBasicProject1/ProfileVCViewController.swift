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
    var address : Address?
    
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
           
           phoneLabel.isUserInteractionEnabled = true
           let phoneTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(makeCall))
           phoneTapGesture.numberOfTouchesRequired = 1
           phoneLabel.addGestureRecognizer(phoneTapGesture)
           
           emailLabel.isUserInteractionEnabled = true
           let emailTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(sendEmail))
           emailTapGesture.numberOfTouchesRequired = 1
           emailLabel.addGestureRecognizer(emailTapGesture)
           
           
       }
       
       
       @objc func makeCall(){
           print("user clicked")
        let phoneNumber = phoneLabel.text!.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)

           guard let number = URL(string: "tel://" + phoneNumber) else { return }
           UIApplication.shared.open(number)
           
       }
    
       
    @objc func sendEmail(){
           print("gmail clicked")
      
       let emailAddress = emailLabel.text!
         if let url = URL(string: "mailto:\(emailAddress)") {
           if #available(iOS 10.0, *) {
             UIApplication.shared.open(url)
           } else {
             UIApplication.shared.openURL(url)}
           }
         }

    


}
