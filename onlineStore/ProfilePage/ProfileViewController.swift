//
//  ProfileViewController.swift
//  onlineStore
//
//  Created by aaa on 3/4/23.
//

import UIKit
import XLPagerTabStrip

class ProfileViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        setUpPager()
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_Login = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        
        let child_signUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
        return [child_Login, child_signUp]
    }
    
    
    func setUpPager() {
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .red
    }
    
}
