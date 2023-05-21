//
//  ColorsTableViewController.swift
//  onlineStore
//
//  Created by aaa on 3/8/23.
//

import UIKit

protocol colorDelegate: AnyObject {
    func changeColor(index: Int)
}

class ColorsTableViewController: UITableViewController {

    var cells = [String]()
    var checkIndex: Int?
    weak var delegate: colorDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cells.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorsTableViewCell", for: indexPath) as! ColorsTableViewCell

        cell.colorName.text = cells[indexPath.row]
        cell.selectionStyle = .none
        if let Index = checkIndex {
            if indexPath.row == Index {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if checkIndex != nil {
            let index = IndexPath(row: checkIndex!, section: 0)
            let cell = tableView.cellForRow(at: index)
            cell?.accessoryType = .none
        }
        cell?.accessoryType = .checkmark
        delegate?.changeColor(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ColorsTableViewCell
        cell.accessoryType = .none
    }
    
}
