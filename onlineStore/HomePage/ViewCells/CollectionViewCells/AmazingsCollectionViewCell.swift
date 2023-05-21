//
//  AmazingsCollectionViewCell.swift
//  onlineStore
//
//  Created by aaa on 2/8/23.
//

import UIKit
import Kingfisher

class AmazingsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPreviewPrice: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func setUp(product: Products) {
        let route = "http://ioscode.freehost.io/DigikalaPhp/amazingImages/"
        let imageLink = route + product.img_name
        let url = URL(string: imageLink)
        productImage.kf.setImage(with: url)
        productName.text = product.name
        productPreviewPrice.text = "\(product.prevPrice) Toman"
        productPrice.text = "\(product.price) Toman"
    }
}
