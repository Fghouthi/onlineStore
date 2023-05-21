//
//  CommentsViewController.swift
//  onlineStore
//
//  Created by aaa on 3/15/23.
//

import UIKit
import Alamofire

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var detail: String!
    
    var allComments: comments!
    
    var rateSection = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        let commentButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(setComment(sender:)))
        navigationItem.rightBarButtonItem = commentButton
        
        getComments()
    }
    
    
    func getComments() {
        AF.request("http://ioscode.freehost.io/DigikalaPhp/readComments.php", method: .post, parameters: ["detail":detail!]).response { response in
            guard response.error == nil else { return }
            do {
                let decoder = JSONDecoder()
                self.allComments = try decoder.decode(comments.self, from: response.data!)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch {
                print("can not decode comments")
            }
        }
    }
    
    
    @objc func setComment(sender: UIBarButtonItem) {
        if UserDefaults.standard.value(forKey: "login") != nil {
            let controller = storyboard?.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
            controller.detail = detail
            navigationController?.pushViewController(controller, animated: true)
        }else {
            print("please login into account!")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 0 {
            return (CGFloat(allComments.param.count) * 40) + 300
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            if allComments != nil {
                return allComments.user.count
            }else {
                return 0
            }
        }else {
            return allComments.param.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommensTableViewCell") as! CommensTableViewCell
            cell.emailLabel.text = allComments.user[indexPath.row]
            cell.likeLabel.text = allComments.like[indexPath.row]
            cell.dislikeLabel.text = allComments.dislike[indexPath.row]
            cell.titleLabel.text = allComments.title[indexPath.row]
            cell.opinionText.text = allComments.text[indexPath.row]
            cell.positiveLabel.text = allComments.positive[indexPath.row]
            cell.negativeLabel.text = allComments.negative[indexPath.row]
            rateSection = indexPath.row
            cell.opinionText.isEditable = false
            return cell
        }else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "ShowRatingTableViewCell", for: indexPath) as! ShowRatingTableViewCell
            cell2.ratingView.editable = false
            cell2.ratingLabel.text = allComments.param[indexPath.row]
            let rate = allComments.paramRate[rateSection][indexPath.row]
            cell2.ratingView.rating = Double(rate)!
            return cell2
        }
    }
}
