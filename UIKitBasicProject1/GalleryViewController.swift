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
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(galleryCollectionView)
        let nibName = UINib(nibName: "CollectionViewCell", bundle: nil)
        galleryCollectionView.register(nibName, forCellWithReuseIdentifier: "CollectionViewCell")
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.dataSource = self
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier:"CollectionViewCell", for: indexPath) as! CollectionViewCell
       cell.userImage.image = UIImage(named: "4")
        cell.userImage.frame = cell.contentView.frame
        cell.userImage.contentMode = .scaleAspectFit
        //cell.userImage.clipsToBounds = true
        return cell
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let flowLayout = galleryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 250, height: 250)
            flowLayout.itemSize = CGSize(width: 250, height: 250)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:   250, height: 250)
        
    }
 
}
