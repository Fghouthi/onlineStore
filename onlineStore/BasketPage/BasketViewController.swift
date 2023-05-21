//
//  BasketViewController.swift
//  onlineStore
//
//  Created by aaa on 3/11/23.
//

import UIKit
import Alamofire

class BasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allPrices: UILabel!
    var products = [basketData]()
    var allPricesArr = [Int]()
    var allPurchase = 0
    override func viewDidLoad() {
        super.viewDidLoad()

       // getBasketData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       // super.viewWillAppear(animated)
        products.removeAll()
        allPricesArr.removeAll()
        allPurchase = 0
        getBasketData()
    }
    
    func getBasketData() {
        guard let email = UserDefaults.standard.value(forKey: "login") else {
            print("please login into app")
            return
        }
        AF.request("http://ioscode.freehost.io/DigikalaPhp/readbasket.php", method: .post, parameters: ["email":email as! String]).response { [weak self] response in
            guard response.error == nil else { return }
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    self?.products = try decoder.decode([basketData].self, from: data!)
                    guard let products = self?.products else { return }
                    for product in products {
                        let price = Int(product.price)!
                        let number = Int(product.number)!
                        let all = price * number
                        self?.allPricesArr.append(all)
                    }
                    
                    self?.allPurchase = self!.allPricesArr.reduce(0, +)
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.allPrices.text = "\(self?.allPurchase ?? 0) Toman"
                    }
                }catch {
                    print("can not decode basket data!")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        cell.selectionStyle = .none
        let product = products[indexPath.row]
        cell.setUp(product: product)
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteButtonClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteButtonClicked(sender: UIButton) {
        let email = UserDefaults.standard.value(forKey: "login") as! String
        AF.request("http://ioscode.freehost.io/DigikalaPhp/deleteBasket.php", method: .post, parameters: ["email":email, "detail":products[sender.tag].detail]).response { [weak self] response in
            guard response.error == nil else { return }
            switch response.result {
            case .success(let data):
                let result = String(data: data!, encoding: .utf8)
                if result == "ok" {
                    self?.products.removeAll()
                    self?.allPricesArr.removeAll()
                    self?.allPurchase = 0
                    self?.getBasketData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func purchaseButtonClicked(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "PurchaseViewController") as! PurchaseViewController
        controller.price = allPurchase
        navigationController?.pushViewController(controller, animated: true)
    }
}
