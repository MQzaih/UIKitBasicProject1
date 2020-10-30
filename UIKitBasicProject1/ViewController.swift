//
//  ViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 26/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit
import Alamofire
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
       let service = Service(baseUrl: "https://jsonplaceholder.typicode.com/users")
        service.getUsers()
        service.completionHandler {[weak self](users,status,message) in
            if status {
                guard let self = self else {return }
                guard let _users = users else { return }
                self.users = _users
                self.userListTable.reloadData()
            }
        }
      
        
        
        
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    @IBAction func AddProfile(_ sender: Any) {
        /*    guard let vc = storyboard?.instantiateViewController(identifier: "add_prof") as? AddProfileViewController
         else {
         return
         }
         present(vc,animated: true)*/
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTable.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        /* cell.userImage.image = UIImage(named: users[indexPath.row].img)*/
         cell.username.text = users[indexPath.row].name
         cell.email.text = users[indexPath.row].email
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
                /*      vc.img = users[index].img*/
                 vc.name = users[index].name
                 vc.email = users[index].email
                 vc.website = users[index].website
                 vc.phone = String(users[index].phone)
                 vc.username = users[index].username
            }
            
        }
    }
    
    @IBAction func unwindToOne (_sender:UIStoryboardSegue){
        
    }
}

