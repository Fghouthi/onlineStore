//
//  DetailTableViewController.swift
//  onlineStore
//
//  Created by aaa on 2/19/23.
//

import UIKit
import Alamofire
import Kingfisher

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var headerImage: UIImageView!

    let data = ["a","b","c","d","g"]
    var image = ""
    var detail: String!
    var index: Int!
    var explain = productExplain(explain: "", color: "", saller: "", warranty: "", number: "0")
    var whichCollection: Int!
    var headerView: UIView!
    var newHeader: CAShapeLayer!
    
    
    var price = ""
    var name = ""
    
    
    private let headerHeight: CGFloat = 250
    private let headerCut: CGFloat = 114
    
    
    let sfImages = ["eye","gearshape.2.fill","ellipsis.message"]
    let thirdSectionLabels = ["Review","Spesifications","Comments"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImage()
        getExplain()
        navigationController?.navigationBar.standardAppearance.backgroundColor = .systemPurple
        //navigationController?.navigationBar.standardAppearance.accessibilityFrame = .zero
       // navigationController?.navigationBar.isHidden = true
        configHeader()
   //     title = "laptop"
 //     navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.tintColor = .white
        
    //    navigationController?.navigationBar.standardAppearance.shadowImage = UIImage()
    }
    
    func setImage() {
        AF.request("http://ioscode.freehost.io/DigikalaPhp/productImage.php", method: .post, parameters: ["detail":detail ?? ""]).response { [weak self] response in
            guard response.error == nil else { return }
            
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    self?.image = try decoder.decode(String.self, from: data!)
                    DispatchQueue.main.async {
                        let route = "http://ioscode.freehost.io/DigikalaPhp/gallery/"
                        let imageLink = route + (self?.image ?? "")
                        let url = URL(string: imageLink)
                        self?.headerImage.kf.setImage(with: url!)
                    }
                }catch {
                    print("could not decode!")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
   
    func getExplain() {
        AF.request("http://ioscode.freehost.io/DigikalaPhp/productDetail.php", method: .post, parameters: ["detail": detail ?? ""]).response { [weak self] response in
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
                    print("could not decode explain!")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configHeader() {
        tableView.backgroundColor = .white
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(headerView)
        
        
        newHeader = CAShapeLayer()
        newHeader.fillColor = UIColor.blue.cgColor
        headerView.layer.mask = newHeader
        
        let newHeight = headerHeight - headerCut / 2
        tableView.contentInset = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newHeight)
        setUp()
    }

    func setUp() {
        let newHeight = headerHeight - headerCut / 2
        var frame = CGRect(x: 0, y: -newHeight, width: tableView.bounds.width, height: headerHeight)
        if tableView.contentOffset.y < newHeight {
            frame.origin.y = tableView.contentOffset.y
            frame.size.height = -tableView.contentOffset.y// - headerCut / 2
        }
        
        headerView.frame = frame
        
            let cut = UIBezierPath()
            cut.move(to: CGPoint(x: 0, y: 0))
            cut.addLine(to: CGPoint(x: frame.width, y: 0))
            cut.addLine(to: CGPoint(x: frame.width, y: frame.height))
        cut.addLine(to: CGPoint(x: 0, y: headerHeight))
            newHeader.path = cut.cgPath
        
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setUp()
        
       // var offset = scrollView.contentOffset.y / 150
        
        if scrollView.contentOffset.y > -2 {
            UIView.animate(withDuration: 0.2) {
              //  self.navigationController?.navigationBar.isHidden = false
//                offset = 1
//                let whiteColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
//                let redColor = UIColor(hue: 0, saturation: offset, brightness: 1, alpha: 1)
               // self.navigationController?.navigationBar.tintColor = whiteColor
               // self.navigationController?.navigationBar.backgroundColor = redColor
                //UIApplication.shared.statusBar?.backgroundColor = redColor
               // self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: whiteColor]
              //  self.navigationController?.navigationBar.barStyle = .default
                
            }
        }else {
            
            UIView.animate(withDuration: 0.2) {
                
              //  let whiteColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
              //  self.navigationController?.navigationBar.isHidden = true
               // self.navigationController?.navigationBar.tintColor = .white
             //   self.navigationController?.navigationBar.backgroundColor = whiteColor
                //UIApplication.shared.statusBar?.backgroundColor = redColor
             //   self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
             //   self.navigationController?.navigationBar.barStyle = .black
            }
        }
    }
    
    
    
    
    @IBAction func backButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    // MARK: - Table view data source
    
    
    
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 0
//        }else if section == 1 {
//            return 5
//        }else {
//            return 16
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = .lightGray
//        if section == 1 {
//            headerView.backgroundColor = .red
//        }
//        return headerView
//    }
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 4
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 134
        } else if indexPath.section == 1 {
            return 189
        } else if indexPath.section == 2 {
            return 55
        }
        return 100
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            return 3
        }else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "FirstFullDetailTableViewCell", for: indexPath) as! FirstFullDetailTableViewCell
            if whichCollection == 1 {
                let onlyName = dataProvider.shared.onlynNames[index]
                cell1.productName.text = onlyName
                title = onlyName
                name = onlyName
            }else if whichCollection == 2 {
                let bestName = dataProvider.shared.bestSallerNames[index]
                cell1.productName.text = bestName
                title = bestName
                name = bestName
            }else if whichCollection == 3 {
                let newName = dataProvider.shared.newestNames[index]
                cell1.productName.text = newName
                title = newName
                name = newName
            }
            cell1.selectionStyle = .none
            return cell1
        }else if indexPath.section == 1 {
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "SecondFullDetailTableViewCell", for: indexPath) as! SecondFullDetailTableViewCell
            if whichCollection == 1 {
                cell2.productPrice.text = "\(dataProvider.shared.onlyPrices[index]) Toman"
                price = dataProvider.shared.onlyPrices[index]
            }else if whichCollection == 2 {
                cell2.productPrice.text = "\(dataProvider.shared.bestSallerPrices[index]) Toman"
                price = dataProvider.shared.bestSallerPrices[index]
            }else if whichCollection == 3 {
                cell2.productPrice.text = "\(dataProvider.shared.newestPrices[index]) Toman"
                price = dataProvider.shared.newestPrices[index]
            }
           
            cell2.productColor.text = explain.color
            cell2.productWarranty.text = explain.warranty
            cell2.productSaller.text = explain.saller
            cell2.selectionStyle = .none
            return cell2
            
        }else if indexPath.section == 2 {
           
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "ThirdFullDetailTableViewCell", for: indexPath) as! ThirdFullDetailTableViewCell
            cell3.img.tintColor = .black
            cell3.img.image = UIImage(systemName: sfImages[indexPath.row])
            cell3.label.text = thirdSectionLabels[indexPath.row]
            cell3.selectionStyle = .none
            return cell3
            
        }else {
           
            let cell4 = tableView.dequeueReusableCell(withIdentifier: "ForthFullDetailTableViewCell", for: indexPath) as! ForthFullDetailTableViewCell
            cell4.descriptionLbl.text = explain.explain
            cell4.selectionStyle = .none
            return cell4
            
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                
            }else if indexPath.row == 1 {
                
            }else {
                let controller = storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
                controller.detail = detail
                navigationController?.pushViewController(controller, animated: true)
            }
            
        }
    }
    
    @IBAction func confirmationButton(_ sender: Any) {
        if UserDefaults.standard.value(forKey: "login") != nil {
            guard let number = Int(explain.number), number > 0 else {
                print("product is not available!")
                return }
            
          //  performSegue(withIdentifier: "confSegue", sender: self)
            let controller = storyboard?.instantiateViewController(withIdentifier: "confirmation") as! ConfirmationViewController
            controller.productExplain = explain
            controller.imageName = image
            controller.name = name
            controller.price = price
            controller.detail = detail
            navigationController?.pushViewController(controller, animated: true)
        }else {
            print("please login into app")
        }
    }
    
}
