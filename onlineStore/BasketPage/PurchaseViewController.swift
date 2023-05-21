//
//  PurchaseViewController.swift
//  onlineStore
//
//  Created by aaa on 3/14/23.
//

import UIKit
import Alamofire

class PurchaseViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mobileLabel: UITextField!
    @IBOutlet weak var adressLabel: UITextField!
    
    var price: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Taeed Pardakht"
        priceLabel.text = "  Final of Price:   \(price!) Toman"
        
    }
    
    @IBAction func finalPurchaseButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Taeede Kharid", message: "Aya mikhahid Pardakht Konid?", preferredStyle: .actionSheet)
        let yes = UIAlertAction(title: "Bale Mikhahem Pardakht Konam", style: .default) { done in
            self.deleteBasket()
        }
        let none = UIAlertAction(title: "Na Monsaref Shodam", style: .destructive)
        
        alert.addAction(yes)
        alert.addAction(none)
        present(alert, animated: true)
    }
 
    
    func deleteBasket() {
        let email = UserDefaults.standard.value(forKey: "login") as! String
        AF.request("http://ioscode.freehost.io/DigikalaPhp/finalPayment.php", method: .post, parameters: ["email":email]).response { response in
            
            switch response.result {
            case .success(let data):
                let message = String(data: data!, encoding: .utf8)
                if message == "ok" {
                    print("basket paid!")
                    return
                }else {
                    self.deleteBasket()
                }
            case .failure(_):
                print("connection error")
                self.deleteBasket()
            }
            
        }
    }
}
