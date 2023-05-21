//
//  LoginViewController.swift
//  onlineStore
//
//  Created by aaa on 3/4/23.
//

import UIKit
import XLPagerTabStrip
import Alamofire

class LoginViewController: UIViewController, IndicatorInfoProvider {
   
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordField.isSecureTextEntry = true
   
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Login")
    }

    
    @IBAction func showHidePassword(_ sender: UISwitch) {
        if sender.isOn {
            passwordField.isSecureTextEntry = false
        }else {
            passwordField.isSecureTextEntry = true
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        guard userNameField.text != "" && passwordField.text != "" else {
            print("empty")
            return
        }
        AF.request("http://ioscode.freehost.io/DigikalaPhp/login.php", method: .post, parameters: ["user":userNameField.text!, "pass":passwordField.text!]).response { response in
            guard response.error == nil else { return }
            guard let message = String(data: response.data!, encoding: .utf8) else { return }
            if message == "ok" {
                let story = UIStoryboard(name: "Main", bundle: nil)
                    let controller = story.instantiateViewController(withIdentifier: "ProfileDetailViewController") as! ProfileDetailViewController
                UserDefaults.standard.set(self.userNameField.text!, forKey: "login")
                self.navigationController?.pushViewController(controller, animated: true)
//                controller.modalTransitionStyle = .crossDissolve
//                controller.modalPresentationStyle = .fullScreen
//                self.present(controller, animated: true)
            }else {
                
            }
        }
        
    }
}
