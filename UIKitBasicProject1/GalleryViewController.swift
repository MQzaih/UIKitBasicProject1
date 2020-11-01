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
    var sec = 0
    var albums = [Album]()
    static let sectionHeaderView = "SectionHeaderView"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(galleryCollectionView)
        galleryCollectionView?.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView")
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
                self.albums = service.separateByAlbum(photos: self.photos)
                self.galleryCollectionView.reloadData()
            }
        }
        
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
        return albums[section].imgs.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
 
        return albums.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier:"CollectionViewCell", for: indexPath) as! CollectionViewCell
          let photoCategory = albums[indexPath.section].imgs
     
          let img = photoCategory[indexPath.item].url
          let imageUrl = URL(string: img)!
          
          let imageData = try! Data(contentsOf: imageUrl)

          let image = UIImage(data: imageData)
          cell.configure(with: image!)
          return cell
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
        sec = indexPath.section
        index = indexPath.item
        self.performSegue(withIdentifier: "fullscreen", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "fullscreen" {
            if let vc = segue.destination as? fullScreenImgViewController {
                let photo1 = albums[sec].imgs[index]
                
                let imageUrlString = photo1.url
                
                let imageUrl = URL(string: imageUrlString)!
                
                let imageData = try! Data(contentsOf: imageUrl)
                
                let image = UIImage(data: imageData)
               
                vc.img = image
                
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableView.identifier, for: indexPath) as! CollectionReusableView
        header.configure()
        
        return header
    }
}

