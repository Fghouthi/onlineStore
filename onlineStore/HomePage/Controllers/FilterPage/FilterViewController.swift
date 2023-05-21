//
//  FilterViewController.swift
//  onlineStore
//
//  Created by aaa on 3/23/23.
//

import UIKit
import Alamofire

protocol filterDelegate: AnyObject {
    func filterProducts(route: String ,_ params: [String:Any])
}

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var paramTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    var whichCollection: Int!
    var filterParams = ["color","price"]
    var index = 0
    var isExist = 0
    var params = [""]
    
    weak var delegate: filterDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
       // getFilterParams()
        
    }
    
    func getFilterParams() {
        AF.request("http://ioscode.freehost.io/DigikalaPhp/filter.php", method: .post, parameters: ["which":whichCollection!]).response { response in
            guard response.error == nil else { return }
            do {
                let decoder = JSONDecoder()
                self.filterParams = try decoder.decode([String].self, from: response.data!)
                DispatchQueue.main.async {
                    self.paramTableView.reloadData()
                }
            }catch {
                print("can not decode filter params!")
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == paramTableView {
            return filterParams.count
        }else {
            return params.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == paramTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterParamTableViewCell") as! FilterParamTableViewCell
            cell.filterLabel.text = filterParams[indexPath.row]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParamsTableViewCell") as! ParamsTableViewCell
            cell.lbl.text = params[indexPath.row]
            cell.selectionStyle = .none
            cell.accessoryType = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == paramTableView {
            index = 0
            if indexPath.row == 0 {
                params = ["black","white","silver","blue","red"]
            }else {
                params = ["more than 1000000","less than 1000000","more than 10000000"]
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }else {
            let cell = tableView.cellForRow(at: indexPath)
            if cell?.accessoryType == .checkmark {
                cell?.accessoryType = .none
            }else {
                cell?.accessoryType = .checkmark
            }
            index = indexPath.row
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            let cell = self.tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
        }
    }
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
      //  print(params[index])
        let route = "http://ioscode.freehost.io/DigikalaPhp/filtering.php"
        delegate?.filterProducts(route: route,["filter":params[index], "kind":(whichCollection + 1), "isExist":isExist])
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func isAvailable(_ sender: UISwitch) {
        if sender.isOn {
            isExist = 1
        }else {
            isExist = 0
        }
    }
}
