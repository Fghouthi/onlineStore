//
//  ConfirmationViewController.swift
//  onlineStore
//
//  Created by aaa on 3/7/23.
//

import UIKit
import Kingfisher
import Alamofire

class ConfirmationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, colorDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addToBasketLabel: UILabel!
    
    var detail:String!
    
    
    var tableData = ["Warranry:", "Select Color"]
    var productExplain: productExplain!
    var imageName: String!
    var name: String!
    var price: String!
    
    var productColor = ""
    var selectIndex: Int? = nil
    
    var colors = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addToBasketLabel.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addToBasketButton))
        addToBasketLabel.addGestureRecognizer(gesture)
        if !productExplain.color.isEmpty {
            let colorArr = productExplain.color.components(separatedBy: "-")
            //        productColor = colorArr.first ?? ""
            //        tableView.reloadData()
            colors = colorArr
        }
        tableViewHeight.constant = CGFloat(tableData.count) * 60
        
        let route = "http://ioscode.freehost.io/DigikalaPhp/gallery/"
        let imageLink = route + imageName
        let url = URL(string: imageLink)
        productImage.kf.setImage(with: url!)
        
        productName.text = name
        productPrice.text = "\(price!) Toman"
        
        
       
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmPageTableViewCell", for: indexPath) as! ConfirmPageTableViewCell
        
        cell.onwanLabel.text = tableData[indexPath.row]
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.tarifLabel.text = productExplain.warranty
        }else {
            cell.tarifLabel.text = productColor
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "ColorsTableViewController") as! ColorsTableViewController
            controller.cells = colors
            controller.checkIndex = selectIndex
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    @objc func addToBasketButton() {
        guard let email = UserDefaults.standard.value(forKey: "login") else {
            print("please login into app")
            return
        }
        
        if !productExplain.color.isEmpty {
            if productColor == "" {
                print("please select color")
                return
            }
        }
        
//        guard productColor != "" else {
//
//            return
//        }
        AF.request("http://ioscode.freehost.io/DigikalaPhp/basket.php", method: .post, parameters: ["email":email as! String, "detail":detail ?? "", "color":productColor,"warranty":productExplain.warranty, "saller":productExplain.saller]).response { response in
            guard response.error == nil else { return }
            let message = String(data: response.data!, encoding: .utf8)
            if message == "ok" {
                print("added to basket!")
            }
        }
        
        
    }
    
    
    

    
    func changeColor(index: Int) {
        productColor = colors[index]
        selectIndex = index
        tableView.reloadData()
    }
}
