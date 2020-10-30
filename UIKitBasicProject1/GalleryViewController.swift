//
//  GalleryViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 26/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit
class GalleryViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var galleryCollectionView : UICollectionView!
    var photos = [Photo]()
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(galleryCollectionView)
        let nibName = UINib(nibName: "CollectionViewCell", bundle: nil)
        galleryCollectionView.register(nibName, forCellWithReuseIdentifier: "CollectionViewCell")
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.dataSource = self
        
        let service = GalleryServer(baseUrl: "https://jsonplaceholder.typicode.com/photos")
        
        service.getPics()
        
        service.completionHandler {[weak self](photos,status,message) in
            if status {
                guard let self = self else {return }
                guard photos != nil else {return }
                self.photos = photos!
                self.galleryCollectionView.reloadData()
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier:"CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let photo1 = photos[indexPath.row]
        //print(photo1.url)
        
        let imageUrlString = photo1.url
        
        let imageUrl = URL(string: imageUrlString)!
        
        let imageData = try! Data(contentsOf: imageUrl)
        
        let image = UIImage(data: imageData)
        cell.configure(with: image!)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  20
        
        let collectionViewSize = collectionView.frame.size.width - padding
        
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < photos.count else {
            return
            
        }
        index = indexPath.row
        self.performSegue(withIdentifier: "fullscreen", sender: self)
        
    }
    
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if segue.identifier == "fullscreen" {
               if let vc = segue.destination as? fullScreenImgViewController {
                let photo1 = photos[index]
                      //print(photo1.url)
                      
                      let imageUrlString = photo1.url
                      
                      let imageUrl = URL(string: imageUrlString)!
                      
                      let imageData = try! Data(contentsOf: imageUrl)
                      
                      let image = UIImage(data: imageData)
                print("*******")
                print(index)
                vc.img = image
                
               }
               
           }
       }
    
}

