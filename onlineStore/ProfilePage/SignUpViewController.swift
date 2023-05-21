//
//  SignUpViewController.swift
//  onlineStore
//
//  Created by aaa on 3/4/23.
//

import UIKit
import XLPagerTabStrip
import Alamofire

class SignUpViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rePasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "SignUp")
    }
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        guard usernameField.text != "" && passwordField.text != "" && rePasswordField.text != "" else {
            print("empty")
            return }
        guard passwordField.text == rePasswordField.text else {
            print("not match")
            return }
        
        AF.request("http://ioscode.freehost.io/DigikalaPhp/signUp.php", method: .post, parameters: ["user":usernameField.text!, "pass":passwordField.text!]).response { response in
            guard response.error == nil else { return }
            guard let message = String(data: response.data!, encoding: .utf8) else { return }
            if message == "ok" {
                let story = UIStoryboard(name: "Main", bundle: nil)
                    let controller = story.instantiateViewController(withIdentifier: "ProfileDetailViewController") as! ProfileDetailViewController
                UserDefaults.standard.set(self.usernameField.text!, forKey: "login")
                self.navigationController?.pushViewController(controller, animated: true)
//                controller.modalTransitionStyle = .crossDissolve
//                controller.modalPresentationStyle = .fullScreen
//                self.present(controller, animated: true)
            }else {
                
            }
        }
    }
}
