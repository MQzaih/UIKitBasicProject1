//
//  GalleryViewController.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 26/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit
class GalleryViewController: UIViewController {
    
    @IBOutlet var galleryCollectionView : UICollectionView!
    var photos = [Photo]()
    var index = 0
    var sec = 0
    var albums = [Album]()
    static let sectionHeaderView = "SectionHeaderView"
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
                self.albums = service.separateByAlbum(photos: self.photos)
                self.galleryCollectionView.reloadData()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "fullscreen" {
            if let vc = segue.destination as? fullScreenImgViewController {
                var photo1 = albums[sec].imgs[index]
                
                let image = photo1.convert(photoToConvert:photo1)
                vc.img = image
                
                
            }
        }
        
    }

}

extension GalleryViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return albums[section].imgs.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return albums.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier:"CollectionViewCell", for: indexPath) as? CollectionViewCell{
            let photoCategory = albums[indexPath.section].imgs
            
            var img = photoCategory[indexPath.item]
            let image = img.convert(photoToConvert:img)
            cell.configure(with: image)
            
            
            return cell
        }
        
        return UICollectionViewCell()
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
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableView.identifier, for: indexPath) as? CollectionReusableView  {
            
            let title = "Album number\(indexPath.section+1)"
            print(title)
            header.configure(Title: title)
            return header
            
        }
        return UICollectionReusableView()
    }
    
}
