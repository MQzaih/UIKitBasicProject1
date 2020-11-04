//
//  ViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 26/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//
import Foundation
import UIKit
class ViewController: UIViewController {
    var newUsers = [user]()
    var filteredUsers = [user]()
    var users = [user] ()
    var index = 0
    var defaults = UserDefaults.standard
    var userToShow : user?
    let userSearchBar = UISearchController(searchResultsController: nil)
    @IBOutlet var userListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRandomNumbers()
        self.userListTable.rowHeight = UITableView.automaticDimension
        self.userListTable.estimatedRowHeight = 100
        
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
            if users != nil{
                self.users = users!
                self.filteredUsers.append(contentsOf: users!)
                users?.forEach({(user1) in
                })
            }
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
        generateRandomNumbers()
        addFromUserDef()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        addFromUserDef()
        filteredUsers = users
        filteredUsers.append(contentsOf: newUsers)
        userListTable.reloadData()
    }
    
    
    func addFromUserDef(){
        if let objects = UserDefaults.standard.value(forKey: "user_object") as? Data {
            let decoder = JSONDecoder()
            if let obj = try? decoder.decode(Array.self, from: objects) as [user]{
                newUsers = obj
                filteredUsers.append(contentsOf: newUsers)
                userListTable.reloadData()
            }
        }
    }
    
    
    
    func filterCurrentDataSource(searchTerm: String){
        if searchTerm.count > 0 {
            let filteredResults = filteredUsers.filter{ $0.name.replacingOccurrences(of: " ", with: "" ).lowercased().contains(searchTerm.replacingOccurrences(of: " ", with:"" ).lowercased())
                
            }
            
            filteredUsers = filteredResults
            userListTable.reloadData()
        }
        userListTable.reloadData()
        
    }
    
    func restoreData (){
        filteredUsers = users
        userListTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
        
    }
    
    @IBAction func AddProfile(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "profile" {
            if let vc = segue.destination as? ProfileVCViewController {
                vc.name = filteredUsers[index].name
                vc.email = filteredUsers[index].email
                vc.website = filteredUsers[index].website
                vc.phone = String(filteredUsers[index].phone)
                vc.username = filteredUsers[index].username
                if filteredUsers[index].company != nil{
                    vc.comp = filteredUsers[index].company!
                }
                if filteredUsers[index].address != nil{
                    vc.address = filteredUsers[index].address!
                }
            }
            
        }
    }
    var previousNumber: UInt32?
    
    func randomNumber() -> UInt32 {
        var randomNumber = arc4random_uniform(10)
        while previousNumber == randomNumber {
            randomNumber = arc4random_uniform(10)
        }
        previousNumber = randomNumber
        return randomNumber
    }
    var randomArray = [Int]()
    func generateRandomNumbers(){
        let randomInt = randomNumber()
        randomArray.append(Int(randomInt))
    }
    
    @IBAction func unwindToOne (_sender:UIStoryboardSegue){
        if _sender.identifier == "backToFirst"
        {
            addFromUserDef()
            filteredUsers = users
            filteredUsers.append(contentsOf: newUsers)
            userListTable.reloadData()
        }
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
        if  let cell = userListTable.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell{
            if randomArray.contains(indexPath.row){
                cell.company.isHidden = false
                cell.companyName.isHidden = false
            }
            cell.company.text = filteredUsers[indexPath.row].company!.name
            cell.username.text = filteredUsers[indexPath.row].name
            cell.email.text = filteredUsers[indexPath.row].email
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userListTable.beginUpdates()
            if newUsers.contains(filteredUsers[indexPath.row]){
            if let indexToRemove = newUsers.firstIndex(of: filteredUsers[indexPath.row]) {
                newUsers.remove(at:indexToRemove)
                let encoder = JSONEncoder()
                let encoded = try? encoder.encode(newUsers)
                defaults.set(encoded, forKey: "user_object")
                
            }
            }
            
            filteredUsers.remove(at: indexPath.row)
            userListTable.deleteRows(at: [indexPath], with: .fade)
            userListTable.endUpdates()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userSearchBar.isActive = false
        guard indexPath.row < filteredUsers.count else {
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
