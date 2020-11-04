//
//  ProfileVCViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 27/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit
import MapKit
import MessageUI
class ProfileVCViewController: UIViewController,MFMailComposeViewControllerDelegate {
    var name = ""
    var email = ""
    var username = " "
    var phone = ""
    var website = " "
    var img = " "
    var address : Address?
    var comp : Company?
    var geo : Geo?
    
    @IBOutlet var userimg : UIImageView!
    @IBOutlet var emailLabel : UILabel!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var phoneLabel : UILabel!
    @IBOutlet var usernameLabel : UILabel!
    @IBOutlet var websiteLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var latlngLabel: UILabel!
    @IBOutlet weak var bsLabel: UILabel!
    
    @IBOutlet weak var catchPhraseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignValues()
        phoneLabel.isUserInteractionEnabled = true
        let phoneTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(makeCall))
        phoneTapGesture.numberOfTouchesRequired = 1
        phoneLabel.addGestureRecognizer(phoneTapGesture)
        emailLabel.isUserInteractionEnabled = true
        let emailTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(sendEmail))
        emailTapGesture.numberOfTouchesRequired = 1
        emailLabel.addGestureRecognizer(emailTapGesture)
        
        latlngLabel.isUserInteractionEnabled = true
        let addressTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(openMapForPlace))
        addressTapGesture.numberOfTouchesRequired = 1
        latlngLabel.addGestureRecognizer(addressTapGesture)
    }
    
    
    func assignValues(){
        emailLabel.text = email
        nameLabel.text = name
        phoneLabel.text = phone
        usernameLabel.text = username
        websiteLabel.text = website
        userimg.image = UIImage(named: "1")
        
        if let addressName = address {
            geo = addressName.geo
            zipcodeLabel.text = addressName.zipcode
            addressLabel.text = addressName.city
            latlngLabel.text = "\(geo!.lat) / \(geo!.lng)"
        }
        
       
        if let company = comp {
            companyLabel.text = company.name
            catchPhraseLabel.text = company.catchPhrase
            bsLabel.text = company.bs
            
        
        }
    }
    
    @objc func openMapForPlace() {
        
        let lat1 : NSString = self.geo!.lat as NSString
        let lng1 : NSString = self.geo!.lng as NSString
        
        let latitude:CLLocationDegrees =  lat1.doubleValue
        let longitude:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Place Name"
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    @objc func makeCall(){
        print("user clicked")
        let phoneNumber = phoneLabel.text!.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
        UIApplication.shared.open(number)
        
    }
    
    
    @objc func sendEmail(){
        
        let emailAddress = emailLabel.text!
        
        if let url = URL(string: "mailto:\(emailAddress)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)}
        }
    }
    
    
    
}
