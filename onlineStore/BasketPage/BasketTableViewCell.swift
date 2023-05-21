//
//  BasketTableViewCell.swift
//  onlineStore
//
//  Created by aaa on 3/12/23.
//

import UIKit
import Kingfisher

class BasketTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productNumber: UILabel!
    @IBOutlet weak var productColor: UILabel!
    @IBOutlet weak var productWarranty: UILabel!
    @IBOutlet weak var productSaller: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(product: basketData) {
        let route = "http://ioscode.freehost.io/DigikalaPhp/gallery/"
        let imageLink = route + product.img_name
        let url = URL(string: imageLink)
        productImage.kf.setImage(with: url!)
        productName.text = product.name
        productWarranty.text = "Warranty  \(product.warranty)"
        productSaller.text =   "Saller    \(product.saller)"
        productColor.text =    "Color     \(product.color)"
        productNumber.text =   "Number    \(product.number)"
        guard let number = Int(product.number), let price = Int(product.price) else {
            productPrice.text = "0 Toman"
            return
        }
        productPrice.text = "\(number * price) Toman"
    }

}
