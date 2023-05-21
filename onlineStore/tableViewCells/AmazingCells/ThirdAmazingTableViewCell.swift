//
//  ThirdAmazingTableViewCell.swift
//  onlineStore
//
//  Created by aaa on 2/16/23.
//

import UIKit

class ThirdAmazingTableViewCell: UITableViewCell {

    @IBOutlet weak var moreBtnConstraint: NSLayoutConstraint!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
   
    @IBAction func moreButtonClicked(_ sender: UIButton) {
        //contentView.layoutIfNeeded()
        moreBtn.alpha = 0
        moreBtn.isEnabled = false
        moreBtn.frame.size.height = 0
        descriptionLabel.numberOfLines = 0
      //  descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 0).isActive = true
        //descriptionLabel.layoutIfNeeded()
    }
    
}
