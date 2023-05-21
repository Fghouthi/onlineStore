//
//  RatingViewController.swift
//  onlineStore
//
//  Created by aaa on 3/15/23.
//

import UIKit
import Alamofire

var ratingValues = [Int]()

class RatingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var detail: String!
    var params = [String]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // detail = "10"
        getParams()
    }
    
    
    func getParams() {
        AF.request("http://ioscode.freehost.io/DigikalaPhp/survey.php", method: .post, parameters: ["detail": detail]).response { response in
            guard response.error == nil else { return }
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    self.params = try decoder.decode([String].self, from: data!)
                    ratingValues = Array(repeating: 0, count: self.params.count)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }catch {
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return params.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell") as! RatingTableViewCell
        cell.ratingView.tag = indexPath.row
        cell.ratingLabel.text = params[indexPath.row]
        cell.ratingView.delegate = self
        return cell
    }
    
    
    @IBAction func continueButtonClicked(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "WriteCommentViewController") as! WriteCommentViewController
        let ratingsArr = ratingValues.map({String($0)}).joined(separator: ",")
        controller.rating = ratingsArr
        controller.detail = detail
        controller.delegate = self
        present(controller, animated: true)
        //navigationController?.pushViewController(controller, animated: true)
    }
    

    @IBAction func exitButtonClicked(_ sender: UIButton) {
        let ratingsArr = ratingValues.map({String($0)}).joined(separator: ",")
        let email = UserDefaults.standard.value(forKey: "login") as! String
        AF.request("http://ioscode.freehost.io/DigikalaPhp/registerComment.php", method: .post, parameters: ["detail":detail! ,"email":email, "param":ratingsArr]).response { response in
            guard response.error == nil  else { return }
            let vc = self.navigationController?.viewControllers[1]
            self.navigationController?.popToViewController(vc!, animated: true)
        }
        
        
    }
}


extension RatingViewController: FloatRatingViewDelegate, ratingDelegate {
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        
        ratingValues[ratingView.tag] = Int(rating)
       
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        
    }
    
    func backToRoot() {
        let vc = self.navigationController?.viewControllers[1]
        self.navigationController?.popToViewController(vc!, animated: true)
    }
}
