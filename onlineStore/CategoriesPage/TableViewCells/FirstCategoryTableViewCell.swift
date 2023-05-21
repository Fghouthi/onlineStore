//
//  FirstCategoryTableViewCell.swift
//  onlineStore
//
//  Created by aaa on 2/28/23.
//

import UIKit
import Kingfisher

class FirstCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
