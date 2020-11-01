//
//  CollectionReusableView.swift
//
//
//  Created by Asal 2 on 31/10/2020.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
static var identifier = "SectionHeaderView"
    
    @IBOutlet weak var CategoryTitle: UILabel!
    public func configure(Title:String){
        CategoryTitle.text! = Title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
