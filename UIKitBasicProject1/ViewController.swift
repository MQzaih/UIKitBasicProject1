//
//  ViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 26/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
class ViewController: UIViewController {
    
    var filteredUsers = [user]()
    var users = [user] ()
    var index = 0
    @IBOutlet var userListTable: UITableView!
    let userSearchBar = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        userListTable.register(nib, forCellReuseIdentifier: "TableViewCell")
        userListTable.delegate = self
        userListTable.dataSource = self
        let service = UserServer(baseUrl: "https://jsonplaceholder.typicode.com/users")
        
        service.fetchUserJSON { (users, err) in
            
            if err != nil {
                print("failed")
                return
            }
            self.users = users!
            self.filteredUsers = users!

            users?.forEach({(user1) in
                print(user1.name)
            })
            self.users = users!
            DispatchQueue.main.async {
                self.userListTable.reloadData()
            }
            
        }
        userSearchBar.searchBar.delegate = self
        userSearchBar.obscuresBackgroundDuringPresentation = false
        userSearchBar.searchResultsUpdater = self
        userSearchBar.searchBar.placeholder = "Search for your user"
        navigationItem.searchController = userSearchBar
        navigationItem.hidesSearchBarWhenScrolling = true
        
    }
    
    
    func filterCurrentDataSource(searchTerm: String){
        if searchTerm.count > 0 {
            filteredUsers = users
            let filteredResults = filteredUsers.filter{ $0.name.replacingOccurrences(of: " ", with: "" ).lowercased().contains(searchTerm.replacingOccurrences(of: " ", with:"" ).lowercased())
                
            }
        
            filteredUsers = filteredResults
            userListTable.reloadData()
        }
        userListTable.reloadData()
        
    }
    
    func restoreData (){
        print("&&&&&")
        print(users)
        filteredUsers = users
        userListTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
        
    }
    
    @IBAction func AddProfile(_ sender: Any) {
        /*    guard let vc = storyboard?.instantiateViewController(identifier: "add_prof") as? AddProfileViewController
         else {
         return
         }
         present(vc,animated: true)*/
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




extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = userSearchBar.searchBar.text {
            filterCurrentDataSource(searchTerm: searchText)
            
        }
    }
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = userListTable.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
          /* cell.userImage.image = UIImage(named: users[indexPath.row].img)*/
          cell.username.text = filteredUsers[indexPath.row].name
          cell.email.text = filteredUsers[indexPath.row].email
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
          userSearchBar.isActive = false
          guard indexPath.row < users.count else {
              return
              
          }
          index = indexPath.row
          self.performSegue(withIdentifier: "profile", sender: self)
      }
}
extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        userSearchBar.isActive = false
        if let searchText = searchBar.text, searchText.isEmpty {
            restoreData()
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        userSearchBar.isActive = false
        if let searchText = searchBar.text, !searchText.isEmpty{
            filterCurrentDataSource(searchTerm: searchText)
        }
    
    }
}
