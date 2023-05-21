//
//  SecondFullDetailTableViewCell.swift
//  onlineStore
//
//  Created by aaa on 2/21/23.
//

import UIKit

class SecondFullDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productColor: UILabel!
    @IBOutlet weak var productWarranty: UILabel!
    @IBOutlet weak var productSaller: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
