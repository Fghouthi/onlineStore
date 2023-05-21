//
//  Amazing_DetailViewController.swift
//  onlineStore
//
//  Created by aaa on 2/15/23.
//

import UIKit
import Auk
import Alamofire

class Amazing_DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topUnderView: UIView!
    @IBOutlet weak var topScroll: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var redBarView: UIView!
    @IBOutlet weak var effectView: UIVisualEffectView!
    @IBOutlet weak var topScrollHeight: NSLayoutConstraint!
    @IBOutlet weak var labelConstant: NSLayoutConstraint!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    var detail: String!
    var index: Int!
    var images = ""
    var explain = productExplain(explain: "", color: "", saller: "", warranty: "", number: "0")
    
    let sfImages = ["eye","gearshape.2.fill","ellipsis.message"]
    let secondSectionLabels = ["Review","Spesifications","Comments"]
    var sliderHeight: CGFloat!
    var content: CGPoint = .zero
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.text = dataProvider.shared.names[index!]
        
        getDetailData()
        getExplainData()
        
        backBtn.setTitle("", for: .normal)
       // tableView.frame = CGRect(x: 0, y: topUnderView.frame.maxY , width: view.frame.width, height: view.frame.height - topUnderView.frame.height)
        redBarView.isHidden = true
        topLabel.isHidden = true
        effectView.alpha = 0
      //  effectView.isHidden = true
      //  sliderHeight = topScroll.frame.height
      //  topScroll.auk.settings.contentMode = .scaleAspectFill
      //  topScroll.auk.show(url: "http://ioscode.freehost.io/DigikalaPhp/banerImages/baner3.jpg")
      //  topScroll.auk.show(url: "http://ioscode.freehost.io/DigikalaPhp/banerImages/baner4.jpg")
        
    }
    
    
    func getDetailData() {
        AF.request("http://ioscode.freehost.io/DigikalaPhp/amazingDetail.php", method: .post, parameters: ["detail":detail ?? ""]).response { [weak self] response in
            guard response.error == nil else { return }
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    self?.images = try decoder.decode(String.self, from: data!)
                    let imagesArr = self?.images.components(separatedBy: ",")
                    let route = "http://ioscode.freehost.io/DigikalaPhp/gallery/"
                    if let imagesArray = imagesArr {
                        for imageName in imagesArray {
                            let imageLink = route + imageName
                            self?.topScroll.auk.show(url: imageLink)
                        }
                    }
                }catch {
                    print("could not decode ima_names!")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getExplainData() {
        AF.request("http://ioscode.freehost.io/DigikalaPhp/productExplain.php", method: .post, parameters: ["detail":detail ?? ""]).response { [weak self] response in
            guard response.error == nil else { return }
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    self?.explain = try decoder.decode(productExplain.self, from: data!)
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    
                }catch {
                   print("could not decode explain data!")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    // tableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 3
        }
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstAmazingTableViewCell", for: indexPath) as! FirstAmazingTableViewCell
            cell.productName.text = dataProvider.shared.names[index!]
            cell.productPrevPrice.text = "\(dataProvider.shared.prevPrices[index!]) Toman"
            cell.productPrice.text = "\(dataProvider.shared.prices[index!]) Toman"
            cell.productColor.text = explain.color
            cell.productWarranty.text = explain.warranty
            cell.productSaller.text = explain.saller
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondAmazingTableViewCell", for: indexPath) as! SecondAmazingTableViewCell
            cell.img.image = UIImage(systemName: sfImages[indexPath.row])
            cell.label.text = secondSectionLabels[indexPath.row]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdAmazingTableViewCell", for: indexPath) as! ThirdAmazingTableViewCell
            cell.descriptionLabel.text = explain.explain
            cell.descriptionLabel.layoutIfNeeded()
            return cell
        }
       
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      //  let constant = topScrollHeight.constant + sliderHeight
       // let constant = topScroll.frame.height - tableView.contentOffset.y
      //  content = tableView.contentOffset
        if tableView.contentOffset.y > 0 {
            if topScrollHeight.constant > 20 {
                
                topScrollHeight.constant -= tableView.contentOffset.y
                let z = topScrollHeight.constant / 250
                effectView.alpha = 1 - z
                //tableView.contentOffset = .zero
               // topScrollHeight.constant = 250
            }else {
               // topScrollHeight.constant = 0
            }
        } else {
            if topScrollHeight.constant < 250 {
               
                topScrollHeight.constant -= tableView.contentOffset.y
               
                let z = topScrollHeight.constant / 250
                effectView.alpha = 1 - z
                //tableView.contentOffset = .zero
               // topScrollHeight.constant = 250
            }
        }
       
//
//        if topScrollHeight.constant < 270 && topScrollHeight.constant > 20 {
//            topScrollHeight.constant -= tableView.contentOffset.y
//            let z = topScrollHeight.constant / 250
//            effectView.alpha = 1 - z
//        }
      //  print("content offset is \(scrollView.contentOffset.y)")
      //  print("height of topView is \(topScroll.frame.height)")
        
        if topScrollHeight.constant <= 64 {
            redBarView.isHidden = false
        }
        
        if topScrollHeight.constant > 64 {
            redBarView.isHidden = true
        }
        if topScrollHeight.constant <= 44 {
            topLabel.isHidden = false
            if labelConstant.constant > 0 {
                labelConstant.constant = topScrollHeight.constant - 21
            }else {
                labelConstant.constant = 0
            }
        }
        
        if topScrollHeight.constant > 44 {
            redBarView.isHidden = true
            labelConstant.constant = 22
        }
       // tableView.contentOffset = content
        
        
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       // tableView.contentOffset = CGPoint(x: 0, y: topScroll.frame.height)
        DispatchQueue.main.async {
            if self.topScrollHeight.constant > 250 {
               // self.tableView.contentOffset = self.content
                UIView.animate(withDuration: 0.3) {
                    self.topScrollHeight.constant = 250
                    self.effectView.alpha = 0
                }
            }
        }
        
        
        if topScrollHeight.constant < 20 {
           // tableView.contentOffset = content
            UIView.animate(withDuration: 0.3) {
                self.topScrollHeight.constant = 25
                
            }
        }
    }
    
    
    @IBAction func dismissButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
