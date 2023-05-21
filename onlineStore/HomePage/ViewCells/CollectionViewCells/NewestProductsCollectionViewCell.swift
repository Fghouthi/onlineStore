//
//  NewestProductsCollectionViewCell.swift
//  onlineStore
//
//  Created by aaa on 2/12/23.
//

import UIKit
import Kingfisher

class NewestProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func setUp(product: Products) {
        let route = "http://ioscode.freehost.io/DigikalaPhp/newestImages/"
        let imageLink = route + product.img_name
        let url = URL(string: imageLink)
        productImage.kf.setImage(with: url!)
        productName.text = product.name
        productPrice.text = "\(product.price) Toman"
    }
}
