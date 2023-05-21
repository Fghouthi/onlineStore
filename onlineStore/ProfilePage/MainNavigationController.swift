//
//  MainNavigationController.swift
//  onlineStore
//
//  Created by aaa on 3/6/23.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.value(forKey: "login") != nil {
            
            performSegue(withIdentifier: "detailPage", sender: self)
        }else {
            performSegue(withIdentifier: "loginPage", sender: self)
        }
        
    }
    
}
