//
//  ViewController.swift
//  onlineStore
//
//  Created by aaa on 2/2/23.
//

import UIKit
import Auk
import moa
import Alamofire
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var slider1: UIScrollView!
    
    
    @IBOutlet weak var baner1Image: UIImageView!
    @IBOutlet weak var baner2Image: UIImageView!
    @IBOutlet weak var baner3Image: UIImageView!
    @IBOutlet weak var baner4Image: UIImageView!
    @IBOutlet weak var baner5Image: UIImageView!
    @IBOutlet weak var baner6Image: UIImageView!
    @IBOutlet weak var baner7Image: UIImageView!
    
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    
    
    @IBOutlet weak var amazingsCollectionView: UICollectionView!
    @IBOutlet weak var onlydigiCollectionView: UICollectionView!
    @IBOutlet weak var bestSallerCollectionView: UICollectionView!
    @IBOutlet weak var newestCollectionView: UICollectionView!
    
    
    @IBOutlet weak var onlyDigiShowLabel: UILabel!
    @IBOutlet weak var bestSallerShowLabel: UILabel!
    @IBOutlet weak var newestShowLabel: UILabel!
    @IBOutlet weak var second1: UILabel!
    @IBOutlet weak var second2: UILabel!
    
    @IBOutlet var ShowAllLabels: [UILabel]!
    
    let provider = dataProvider()
    var slider1_Contents = [Slider1Struct]()
    var amazing_Products = [Products]()
    var onlydigi_Products = [Products]()
    var best_Saller_Products = [Products]()
    var newestProducts = [Products]()
    
    var secondTikTok = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOfferTime()
        //startTimer()
        slider1.auk.settings.contentMode = .scaleToFill
        let banerImages:[UIImageView] = [baner1Image, baner2Image, baner3Image, baner4Image, baner5Image, baner6Image, baner7Image]
        fetchAllSlider1Data()
        fetchAmazingsAllData()
        fetchOnlyDigiAllData()
        fetchBestSallerProducts()
        fetchNewestProducts()
        let route = "http://ioscode.freehost.io/DigikalaPhp/banerImages/baner"
        for index in 0..<banerImages.count {
            let imageLink = route + "\(index + 1).jpg"
            let url = URL(string: imageLink)
            banerImages[index].kf.setImage(with: url)
        }
        
        ShowAllLabels.forEach {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAllProducts)))
        }
        
      //  let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showAllProducts(sender:)))
//        onlyDigiShowLabel.addGestureRecognizer(tapGesture)
//        bestSallerShowLabel.addGestureRecognizer(tapGesture)
//        newestShowLabel.addGestureRecognizer(tapGesture)
    }
    
    func getOfferTime() {
        AF.request("http://ioscode.freehost.io/DigikalaPhp/timer.php").response { response in
            guard response.error == nil else { return }
            do {
                let decoder = JSONDecoder()
                let time = try decoder.decode(Int.self, from: response.data!)
                if time > 0 {
                    offerTime.shared.time = time
                    self.startTimer()
                    self.amazingsCollectionView.reloadData()
                }
                
            }catch {
                print("can not decode offerTime!")
            }
            
        }
    }

    func startTimer() {
         Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
             
             if offerTime.shared.time > 0 {
                self.countDownTimer()
            }else {
                offerTime.shared.time = 0
                timer.invalidate()
                self.second1.alpha = 1
                self.second2.alpha = 1
                DispatchQueue.main.async {
                    self.amazingsCollectionView.reloadData()
                }
            }
             
            
        })
    }
    
    func countDownTimer() {
        secondTikTok.toggle()
        if secondTikTok {
            second1.alpha = 0
            second2.alpha = 0
        }else {
            second1.alpha = 1
            second2.alpha = 1
        }
        
        let endTime = offerTime.shared.time
        let day = endTime / 86400
        let hour = (endTime / 3600) % 24
        let minute = (endTime / 60) % 60
        //let second = Int(endTime) % 60
        dayLabel.text = "\(day)"
        if hour < 10 {
            hourLabel.text = "0" + String(hour)
        }else {
            hourLabel.text = String(hour)
        }
        if minute < 10 {
            minuteLabel.text = "0" + String(minute)
        }else {
            minuteLabel.text = String(minute)
        }
        offerTime.shared.time -= 1
        
    }
    @objc func showAllProducts(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel else { return }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShowAllViewController") as! ShowAllViewController
        
        switch label.tag {
        case 0:
            vc.whichCollection = 1
            vc.topTitle = "only Digi"
            vc.prevProducts = onlydigi_Products
        case 1:
            vc.whichCollection = 2
            vc.topTitle = "best Saller"
            vc.prevProducts = best_Saller_Products
        case 2:
            vc.whichCollection = 3
            vc.topTitle = "newest"
            vc.prevProducts = newestProducts
        default:
            break
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }

    func fetchAllSlider1Data() {
        AF.request("http://ioscode.freehost.io/DigikalaPhp/homePage.php?work=slider1").response {[weak self] response in
            
            guard response.error == nil else { return }
            guard let self = self else { return }
            
            switch response.result {
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let sliders = try decoder.decode([Slider1Struct].self, from: data!)
                    self.slider1_Contents = sliders
                    let firstLink = "http://ioscode.freehost.io/DigikalaPhp/slider1Images/"
                    for slider in self.slider1_Contents {
                        let fullLink = firstLink + slider.photoname
                        self.slider1.auk.show(url: fullLink)
                    }
                    self.slider1.auk.startAutoScroll(delaySeconds: 3)
                } catch {
                    print("slider1 decoding error!")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchAmazingsAllData() {
        AF.request("http://ioscode.freehost.io/DigikalaPhp/homePage.php?work=amazings").response { [weak self] response in
            guard response.error == nil else { return }
            
            switch response.result {
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    self?.amazing_Products = try decoder.decode([Products].self, from: data!)
                    
                    DispatchQueue.main.async {
                        
                        //self?.amazing_Products = products
                        self?.amazingsCollectionView.reloadData()
                    }
                   
                    for product in self!.amazing_Products {
//                        dataProvider.shared.names.append(product.name)
//                        dataProvider.shared.prices.append(product.price)
//                        dataProvider.shared.prevPrices.append(product.prevPrice)
                        dataProvider.shared.setValues(whichCollection: 0, value: product)
                    }
                    
                }catch {
                    print("amazings decoding error!")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func fetchOnlyDigiAllData() {
        
        AF.request("http://ioscode.freehost.io/DigikalaPhp/homePage.php?work=allOnlyDigi").response { [weak self] response in
            guard response.error == nil else { return }
            
            switch response.result {
                
            case .success(let data):
                
                do {
                    let decode = JSONDecoder()
                    self?.onlydigi_Products = try decode.decode([Products].self, from: data!)
                    DispatchQueue.main.async {
                        
                        self?.onlydigiCollectionView.reloadData()
                        
                    }
                    
                    for product in self!.onlydigi_Products {
//                        dataProvider.shared.onlyPrices.append(product.price)
//                        dataProvider.shared.onlynNames.append(product.name)
                        dataProvider.shared.setValues(whichCollection: 1, value: product)
                    }
                    
                }catch {
                    print("could not decode onlyDigi data!")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchBestSallerProducts() {
        
        AF.request("http://ioscode.freehost.io/DigikalaPhp/homePage.php?work=allBestSaller").response { [weak self] response in
            guard response.error == nil else { return }
            
            switch response.result {
            case .success(let data):
                
                do {
                    let decoder = JSONDecoder()
                    self?.best_Saller_Products = try decoder.decode([Products].self, from: data!)
                    
                    DispatchQueue.main.async {
                         
                        self?.bestSallerCollectionView.reloadData()
                    }
                    
                    for product in self!.best_Saller_Products {
//                        dataProvider.shared.bestSallerPrices.append(product.price)
//                        dataProvider.shared.bestSallerNames.append(product.name)
                        dataProvider.shared.setValues(whichCollection: 2, value: product)
                        
                    }
                    
                }catch {
                    print("could not decode best saller products!")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchNewestProducts() {
        AF.request("http://ioscode.freehost.io/DigikalaPhp/homePage.php?work=allNewest").response { [weak self] response in
            guard response.error == nil else { return }
            
            switch response.result {
            case .success(let data):
                
                do {
                    let decoder = JSONDecoder()
                    self?.newestProducts = try decoder.decode([Products].self, from: data!)
                    DispatchQueue.main.async {
                    
                        self?.newestCollectionView.reloadData()
                    }
                    for product in self!.newestProducts {
//                        dataProvider.shared.newestPrices.append(product.price)
//                        dataProvider.shared.newestNames.append(product.name)
                        dataProvider.shared.setValues(whichCollection: 3, value: product)
                    }
                    
                }catch {
                   print("could not decode newest products!")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func slider1Taped(_ sender: UITapGestureRecognizer) {
        
    }
   
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == amazingsCollectionView {
            return amazing_Products.count
        }else if collectionView == onlydigiCollectionView {
            let count = Double(onlydigi_Products.count) * 0.5
            let number = Int(count)
            return number
        }else if collectionView == bestSallerCollectionView {
            let count = Double(best_Saller_Products.count) * 0.5
            let number = Int(count)
            return number
        }else if collectionView == newestCollectionView {
            let count = Double(newestProducts.count) * 0.5
            let number = Int(count)
            return number
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == amazingsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmazingsCollectionViewCell", for: indexPath) as! AmazingsCollectionViewCell
            let amazingProduct = amazing_Products[indexPath.row]
            cell.setUp(product: amazingProduct)
            return cell
        }else if collectionView == onlydigiCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnlyDigiCollectionViewCell", for: indexPath) as! OnlyDigiCollectionViewCell
            let onlydigiProduct = onlydigi_Products[indexPath.row]
            cell.setUp(product: onlydigiProduct)
            return cell
        }else if collectionView == bestSallerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestSallerProductsCollectionViewCell", for: indexPath) as! BestSallerProductsCollectionViewCell
            let bestSallerProduct = best_Saller_Products[indexPath.row]
            cell.setUp(product: bestSallerProduct)
            return cell
        }else if collectionView == newestCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewestProductsCollectionViewCell", for: indexPath) as! NewestProductsCollectionViewCell
            let newestProdutc = newestProducts[indexPath.row]
            cell.setUp(product: newestProdutc)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == amazingsCollectionView {
            let Detail = amazing_Products[indexPath.row].detail
            let controller = storyboard?.instantiateViewController(withIdentifier: "Amazing_DetailViewController") as! Amazing_DetailViewController
            controller.detail = Detail
            controller.index = indexPath.row
            navigationController?.pushViewController(controller, animated: true)
            //controller.modalPresentationStyle = .fullScreen
            //present(controller, animated: true)
            
        }else if collectionView == onlydigiCollectionView {
            let Detail = onlydigi_Products[indexPath.row].detail
            let controller = storyboard?.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
            controller.detail = Detail
            controller.index = indexPath.row
            controller.whichCollection = 1
           // controller!.modalPresentationStyle = .fullScreen
           // present(controller!, animated: true)
            navigationController?.pushViewController(controller, animated: true)
            
        }else if collectionView == bestSallerCollectionView {
            let Detail = best_Saller_Products[indexPath.row].detail
            let controller = storyboard?.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
            controller.detail = Detail
            controller.index = indexPath.row
            controller.whichCollection = 2
           // controller!.modalPresentationStyle = .fullScreen
           // present(controller!, animated: true)
            navigationController?.pushViewController(controller, animated: true)
            
        }else if collectionView == newestCollectionView {
            let Detail = newestProducts[indexPath.row].detail
            let controller = storyboard?.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
            controller.detail = Detail
            controller.index = indexPath.row
            controller.whichCollection = 3
           // controller!.modalPresentationStyle = .fullScreen
           // present(controller!, animated: true)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
