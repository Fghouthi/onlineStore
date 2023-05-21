//
//  ProfileDetailViewController.swift
//  onlineStore
//
//  Created by aaa on 3/6/23.
//

import UIKit

class ProfileDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        navigationItem.setHidesBackButton(true, animated: false)
        let name = UserDefaults.standard.value(forKey: "login") as! String
        nameLabel.text = name
        navigationController?.navigationBar.tintColor = .white
        let rightButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(exitAccount(_ :)))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func exitAccount(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(nil, forKey: "login")
        performSegue(withIdentifier: "mainLogin", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .fullScreen
    }
}
