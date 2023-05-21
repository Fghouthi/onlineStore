//
//  AmazingsDetailViewController.swift
//  onlineStore
//
//  Created by aaa on 2/13/23.
//

import UIKit
import Auk

class AmazingsDetailViewController: UIViewController {

    @IBOutlet weak var imageSlider: UIScrollView!
    @IBOutlet weak var moreLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var moreBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSlider.auk.settings.contentMode = .scaleAspectFill
        imageSlider.auk.show(url: "http://ioscode.freehost.io/DigikalaPhp/banerImages/baner3.jpg")
        imageSlider.auk.show(url: "http://ioscode.freehost.io/DigikalaPhp/banerImages/baner4.jpg")
        moreLabel.numberOfLines = 2
       
        
    }
   
  
    @IBAction func moreButtonClicked(_ sender: UIButton) {
        moreBtn.alpha = 0
        moreBtn.isEnabled = false
        moreBtnHeightConstraint.constant = 0
        scrollableView.layoutIfNeeded()
        moreLabel.numberOfLines = 0
        moreLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
    }
    
}
