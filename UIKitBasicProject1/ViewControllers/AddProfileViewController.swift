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
    var warning = ""
    var city = ""
    
    var company : Company?
    var address : Address?
    
    var newUsers = [user]()
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var websiteText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var cityText : UITextField!
    @IBOutlet weak var zipcodeText : UITextField!
    @IBOutlet weak var latText : UITextField!
    @IBOutlet weak var lngText : UITextField!
    @IBOutlet weak var companyText : UITextField!
    @IBOutlet weak var bsText : UITextField!
    @IBOutlet weak var catchPhraseText : UITextField!
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func validateInfo(_ sender: Any) {
        if !checkIfFilledRequired(){
            return
        }
        else {
            let check = isValidEmail(emailText.text!)
            if check == false {
                warning = "Please Enter a Valid Email!"
                print(warning)
                return
            }
            
            name = nameText.text!
            username = usernameText.text!
            phone = phoneText.text!
            email = emailText.text!
            website = websiteText.text!
            
            
            if cityText.text! != "" {
                address?.city = cityText.text!
            }
            
            if zipcodeText.text != "" {
                address?.zipcode = zipcodeText.text!
            }
            if (latText.text! != "") && (lngText.text! != "")
            {
                address?.geo.lat = latText.text!
                address?.geo.lng = lngText.text!
            }
            
            if companyText.text! != "" {
                company?.name = companyText.text!
            }
            if bsText.text! != "" {
                company?.bs = bsText.text!
            }
            
            if catchPhraseText.text! != "" {
                company?.catchPhrase = catchPhraseText.text!
            }
            addToUser()
            
            restart()
            
        }
    }
    
    
    func addToUser (){
        let newUser = user(fullName: name, username: username, phone: phone, emailAddress: email, website: website,company: company)
        newUsers.append(newUser)
        let encoder = JSONEncoder()
        let encoded = try? encoder.encode(newUsers)
        defaults.set(encoded, forKey: "user_object")
        
    }
    
    func checkIfFilledRequired() -> Bool{
        if nameText.text == "" || usernameText.text == "" || websiteText.text == "" || emailText.text == ""
        {
            warning = "Please Fill All Information Required!"
            print(warning)
            return false
        }
        return true
    }
    
    
    func restart (){
        
        emailText.text = ""
        nameText.text = ""
        usernameText.text = ""
        websiteText.text = " "
        phoneText.text = " "
        cityText.text = " "
        zipcodeText.text = " "
        latText.text = " "
        lngText.text = ""
        companyText.text = " "
        bsText.text = " "
        catchPhraseText.text = " "
        
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let flagEmail = emailPred.evaluate(with: email)
        // print(x)
        return flagEmail
    }
    
    
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
        
        if  let destVC = segue.destination as? ViewController {
            destVC.newUsers.append(contentsOf: newUsers)
           // destVC.filteredUsers.append(contentsOf: newUsers)
            //  destVC.userListTable.reloadData()
        }
        
    }
}
