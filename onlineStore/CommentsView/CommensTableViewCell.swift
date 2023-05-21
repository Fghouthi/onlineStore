//
//  CommensTableViewCell.swift
//  onlineStore
//
//  Created by aaa on 3/21/23.
//

import UIKit

class CommensTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dislikeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var opinionText: UITextView!
    @IBOutlet weak var positiveLabel: UILabel!
    @IBOutlet weak var negativeLabel: UILabel!
    @IBOutlet weak var ratingTable: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CommensTableViewCell{
    func setDelegateAndDataSourse<s: UITableViewDelegate & UITableViewDataSource>(_ DelegateAndDatasourse: s, forRow row: Int) {
        ratingTable.delegate = DelegateAndDatasourse
        ratingTable.dataSource = DelegateAndDatasourse
        ratingTable.reloadData()
    }
}
