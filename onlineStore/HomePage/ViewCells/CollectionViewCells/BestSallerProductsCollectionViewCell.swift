//
//  BestSallerProductsCollectionViewCell.swift
//  onlineStore
//
//  Created by aaa on 2/11/23.
//

import UIKit
import Kingfisher

class BestSallerProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func setUp(product: Products) {
        let route = "http://ioscode.freehost.io/DigikalaPhp/bestSallerImages/"
        let imageLink = route + product.img_name
        let url = URL(string: imageLink)
        productImage.kf.setImage(with: url!)
        productName.text = product.name
        productPrice.text = "\(product.price) Toman"
    }
}
