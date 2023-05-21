//
//  showAllTableViewCell.swift
//  onlineStore
//
//  Created by aaa on 3/23/23.
//

import UIKit
import Kingfisher

class showAllTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    var imageRoute = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setUp(product: Products, whichCollecton: Int) {
        switch whichCollecton {
        case 1: imageRoute = "onlydigiImages"
        case 2: imageRoute = "bestSallerImages"
        case 3: imageRoute = "newestImages"
        default: break
        }
        let route = "http://ioscode.freehost.io/DigikalaPhp/\(imageRoute)/\(product.img_name)"
        let url = URL(string: route)
        productImage.kf.setImage(with: url!)
        productName.text = product.name
        productPrice.text = product.price
    }
}
