//
//  ShowAllViewController.swift
//  onlineStore
//
//  Created by aaa on 3/22/23.
//

import UIKit
import Alamofire

class ShowAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, filterDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var whichCollection: Int!
    var topTitle: String?
    var allProducts = [Products]()
    var prevProducts = [Products]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let text = topTitle != nil ? "\(topTitle!) Products" : ""
        title = text
        setRouteAndGetProducts()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let controllers = navigationController?.viewControllers else { return }
        guard let controller = controllers.last else { return }
        if controller.isKind(of: HomeViewController.self) {
            dataProvider.shared.clearValues(whichCollection: whichCollection)
            for product in prevProducts {
                dataProvider.shared.setValues(whichCollection: whichCollection, value: product)
            }
        }
    }
    
    func setRouteAndGetProducts() {
        let route = "http://ioscode.freehost.io/DigikalaPhp/homePage.php"
        guard let index = whichCollection else { return }
        switch index {
        case 1:
            getAllProducts(route:route ,params: ["work":"allOnlyDigi"], collection: nil)
        case 2:
            getAllProducts(route: route,params: ["work":"allBestSaller"], collection: nil)
        case 3:
            getAllProducts(route: route,params: ["work":"allNewest"], collection: nil)
        default: break
        }
    }
    
    func getAllProducts(route: String,params: [String:Any], collection: Int?) {
        AF.request(route, method: .post, parameters: params).response { response in
            guard response.error == nil else { return }
            do {
                let decoder = JSONDecoder()
                self.allProducts = try decoder.decode([Products].self, from: response.data!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                if let collection = collection {
                    dataProvider.shared.clearValues(whichCollection: collection)
                    for product in self.allProducts {
                        dataProvider.shared.setValues(whichCollection: collection, value: product)
                    }
                }
                
            }catch {
                print("can not decode all products!")
            }
        }
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showAllTableViewCell") as! showAllTableViewCell
        let product = allProducts[indexPath.row]
        cell.setUp(product: product, whichCollecton: whichCollection)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
        vc.whichCollection = whichCollection
        vc.detail = allProducts[indexPath.row].detail
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func filterProducts(route: String, _ params: [String : Any]) {
        getAllProducts(route: route, params: params, collection: whichCollection)
    }
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.whichCollection = whichCollection
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func sortButtonClicked(_ sender: UIButton) {
        let route = "http://ioscode.freehost.io/DigikalaPhp/sort.php"
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let ascending = UIAlertAction(title: "sort by ascending", style: .default) { _ in
            self.getAllProducts(route: route, params: ["sort":"ascending", "kind":self.whichCollection + 1], collection: self.whichCollection)
        }
        let descent = UIAlertAction(title: "sort by descent", style: .default) { _ in
            self.getAllProducts(route: route, params: ["sort":"descent", "kind":self.whichCollection + 1], collection: self.whichCollection)
        }
        let visit = UIAlertAction(title: "sort by view", style: .default) { _ in
            self.getAllProducts(route: route, params: ["sort":"view", "kind":self.whichCollection + 1], collection: self.whichCollection)
        }
        let bestSaller = UIAlertAction(title: "sort by bestSaller", style: .default) { _ in
            self.getAllProducts(route: route, params: ["sort":"bestSaller","kind":self.whichCollection + 1], collection: self.whichCollection)
        }
        alert.addAction(ascending)
        alert.addAction(descent)
        alert.addAction(visit)
        alert.addAction(bestSaller)
        present(alert, animated: true)
    }
}
