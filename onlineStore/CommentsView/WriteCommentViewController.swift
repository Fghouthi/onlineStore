//
//  WriteCommentViewController.swift
//  onlineStore
//
//  Created by aaa on 3/18/23.
//

import UIKit
import Alamofire

protocol ratingDelegate: AnyObject {
    func backToRoot()
}

class WriteCommentViewController: UIViewController {

    var rating: String!
    var detail: String!
    
    @IBOutlet weak var ratinglabel: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var positiveText: UITextField!
    @IBOutlet weak var negativeText: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: ratingDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        ratinglabel.text = "Rating:  \(rating ?? "")"
        
    }
    
    
    @IBAction func sendCommentBtnClicked(_ sender: UIButton) {
        guard titleText.text != "" && positiveText.text != "" && negativeText.text != "" && textView.text != "" else {
            print("empty Information found")
            return
        }
        let email = UserDefaults.standard.value(forKey: "login") as! String
        AF.request("http://ioscode.freehost.io/DigikalaPhp/registerComment.php", method: .post, parameters: ["title":titleText.text!, "positive":positiveText.text!, "negative":negativeText.text!, "text":textView.text!, "email":email, "detail":detail!,"param":rating!]).response { response in
            guard response.error == nil else { return }
            self.dismiss(animated: true) {
                self.delegate?.backToRoot()
            }
            
        }
    }

}
