//
//  ViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 26/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var myData = ["first","second","third"]
    @IBOutlet var userListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        userListTable.register(nib, forCellReuseIdentifier: "TableViewCell")
        userListTable.delegate = self
        userListTable.dataSource = self
        //view.backgroundColor =        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTable.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.username.text = myData[indexPath.row]
        cell.email.text = "hi"
return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            userListTable.beginUpdates()
            myData.remove(at: indexPath.row)
            userListTable.deleteRows(at: [indexPath], with: .fade)
            userListTable.endUpdates()
        }
        
    }
}

