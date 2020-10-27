//
//  ViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 26/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var myData = ["","second","third"]
    var users = [user] ()
    var rqm = 0
    @IBOutlet var userListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        userListTable.register(nib, forCellReuseIdentifier: "TableViewCell")
        userListTable.delegate = self
        userListTable.dataSource = self
        
        users.append(user(fullName: "Gucci ",username: "@diamond",phone: 05999,emailAddress: "mqzaih@asaltech.com",website: "www.me.com"))
        users.append(user(fullName: "Gucci2 ",username: "@diamond",phone: 05999,emailAddress: "mqzaih@asaltech.com",website: "www.me.com"))
        users.append(user(fullName: "Gucci3 ",username: "@diamond",phone: 05999,emailAddress: "mqzaih@asaltech.com",website: "www.me.com"))
        users.append(user(fullName: "Gucci4 ",username: "@diamond",phone: 05999,emailAddress: "mqzaih@asaltech.com",website: "www.me.com"))
        //view.backgroundColor =        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTable.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.username.text = users[indexPath.row].fullName
        cell.email.text = users[indexPath.row].emailAddress
return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            userListTable.beginUpdates()
            users.remove(at: indexPath.row)
            userListTable.deleteRows(at: [indexPath], with: .fade)
            userListTable.endUpdates()
            }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row < users.count else {
print("hi")
            return

        }
        rqm = indexPath.row
        self.performSegue(withIdentifier: "profile", sender: self)

    }
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("hsdjhdehd&&&&&&&")
    print(segue.identifier)
    if segue.identifier == "profile" {
        print(segue.destination)
        if let vc = segue.destination as? ProfileVCViewController {
            vc.name = users[rqm].fullName
            vc.email = users[rqm].emailAddress
            vc.website = users[rqm].website
            vc.phone = String(users[rqm].phone)
            vc.username = users[rqm].username
        print("in")
        }
       else {
        print ("out ")
        }
    }
    }

}

