//
//  CollectionViewCell.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 26/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func configure(with image: UIImage){
        
        userImage.image = image
            userImage.frame = CGRect(x:0,y:0,width:contentView.frame.size.width, height:contentView.frame.size.height)
    }
    
}
