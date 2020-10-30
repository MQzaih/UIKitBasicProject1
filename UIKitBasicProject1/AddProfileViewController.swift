//
//  AddProfileViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 29/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit

class AddProfileViewController: UIViewController {
    
    var name = ""
    var email = ""
    var website = ""
    var username = ""
    var phone = ""
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var websiteText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var warning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    var user2 : user?
    
    @IBAction func validateInfo(_ sender: Any) {
        
        if nameText.text == "" || usernameText.text == "" || websiteText.text == "" || emailText.text == ""{
            warning.text = "Please Fill All Information Required!"
            
        }
        else {
            let check = isValidEmail(emailText.text!)
            if check == false {
                warning.text = "Please Enter a Valid Email!"
                return
            }
            email = emailText.text!
            website = websiteText.text!
            username = usernameText.text!
            name = nameText.text!
            print(email)
            restart()
           // self.presentingViewController?.dismiss(animated: true, completion: nil)

         //   performSegue(withIdentifier: "first", sender: self)
        }
        
        
    }
    
    func restart (){
        
        emailText.text = ""
        nameText.text = ""
        usernameText.text = ""
        websiteText.text = " "
        
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let x = emailPred.evaluate(with: email)
        // print("hi")
        print(x)
        return emailPred.evaluate(with: email)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
        print("now name")
        print(name)
        print("now email")
        
        print(email)
        print("now website")
        
        print(website)
        let destVC = segue.destination as! ViewController
      //  destVC.users.append(user(fullName: name, username: username, phone: 1, emailAddress: email, website: website, img: "1"))
        destVC.userListTable.reloadData()
        
    }
}
