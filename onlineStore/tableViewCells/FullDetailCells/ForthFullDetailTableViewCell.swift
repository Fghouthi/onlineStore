//
//  ForthFullDetailTableViewCell.swift
//  onlineStore
//
//  Created by aaa on 2/21/23.
//

import UIKit

class ForthFullDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func moreButtonClicked(_ sender: UIButton) {
        moreBtn.frame.size.height = 0
        moreBtn.alpha = 0
        moreBtn.isHidden = true
        descriptionLbl.numberOfLines = 0
        //descriptionLbl.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 8).isActive = true
       // descriptionLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
    }
}
