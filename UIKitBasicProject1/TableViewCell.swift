//
//  TableViewCell.swift
//  UIKitBasicProject1
//
//  Created by Asal 2 on 26/10/2020.
//  Copyright © 2020 Asal 2. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var username : UILabel!
    @IBOutlet var email : UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImage.image = UIImage(named: "1")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
