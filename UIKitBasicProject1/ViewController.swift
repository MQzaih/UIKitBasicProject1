//
//  ViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 26/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var users = [user] ()
    var index = 0
    @IBOutlet var userListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        userListTable.register(nib, forCellReuseIdentifier: "TableViewCell")
        userListTable.delegate = self
        userListTable.dataSource = self
        
        users.append(user(fullName: "Gucci Cat ",username: "@Gucci",phone: 05999,emailAddress: "gucci@asaltech.com",website: "www.gucci.com", img: "1"))
        users.append(user(fullName: "Gucci2 Cat",username: "@Gucci2",phone: 05999,emailAddress: "gucci2@asaltech.com",website: "www.gucci2.com", img: "2"))
        users.append(user(fullName: "Gucci3 Cat",username: "@Gucci3",phone: 05999,emailAddress: "gucci3@asaltech.com",website: "www.gucci3.com", img: "3"))
        users.append(user(fullName: "Gucci4 Cat",username: "@Gucci4",phone: 05999,emailAddress: "gucci4@asaltech.com",website: "www.gucci4.com", img: "4"))
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTable.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.userImage.image = UIImage(named: users[indexPath.row].img)
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
            return

        }
        index = indexPath.row
        self.performSegue(withIdentifier: "profile", sender: self)

    }
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
    if segue.identifier == "profile" {
        if let vc = segue.destination as? ProfileVCViewController {
            vc.img = users[index].img
            vc.name = users[index].fullName
            vc.email = users[index].emailAddress
            vc.website = users[index].website
            vc.phone = String(users[index].phone)
            vc.username = users[index].username
        }
    
    }
    }

}

