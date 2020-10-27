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
    var images = [
    UIImage(named: "1"),
    UIImage(named: "2"),
    UIImage(named: "5"),
    UIImage(named: "4"),
    UIImage(named: "3")
].compactMap({$0})

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(galleryCollectionView)
        let nibName = UINib(nibName: "CollectionViewCell", bundle: nil)
        galleryCollectionView.register(nibName, forCellWithReuseIdentifier: "CollectionViewCell")
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.dataSource = self
        
        
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier:"CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .darkGray
        let arrayKey = Int(arc4random_uniform(UInt32(images.count)))
        let randImage = images[arrayKey]
        cell.configure(with: randImage)
        
        images.remove(at: arrayKey)
     //   cell.userImage.frame = cell.contentView.frame
       // cell.userImage.contentMode = .scaleAspectFit
        //cell.userImage.clipsToBounds = true
        return cell
    }
    

    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
         }
         


    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

             let padding: CGFloat =  20

             let collectionViewSize = collectionView.frame.size.width - padding


    

             return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)

         }
      
 
}
