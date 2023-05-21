//
//  CategoriesTableViewController.swift
//  onlineStore
//
//  Created by aaa on 2/28/23.
//

import UIKit
import Alamofire
import Kingfisher

class CategoriesTableViewController: UITableViewController {

    var objects = [categoryStruct]()
    var categories = [Category]()
    
    var digital = [String]()
    var tool = [String]()
    var health = [String]()
    var clothes = [String]()
    var home = [String]()
    var book = [String]()
    
    
    var digitalPic = [String]()
    var toolPic = [String]()
    var healthPic = [String]()
    var clothesPic = [String]()
    var homePic = [String]()
    var bookPic = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        getCategories()
        
    }

    
    
    func getCategories() {
        
        AF.request("http://ioscode.freehost.io/DigikalaPhp/category2.php").response { [weak self] response in
            guard response.error == nil else { return }
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    self?.categories = try decoder.decode([Category].self, from: data!)
                    guard let categories = self?.categories else { return }
                        for category in categories {
                            switch category.cat {
                            case "1":
                                self?.digital.append(category.title)
                                self?.digitalPic.append(category.img_name)
                            case "2":
                                self?.book.append(category.title)
                                self?.bookPic.append(category.img_name)
                            case "3":
                                self?.home.append(category.title)
                                self?.homePic.append(category.img_name)
                            case "4":
                                self?.clothes.append(category.title)
                                self?.clothesPic.append(category.img_name)
                            case "5":
                                self?.health.append(category.title)
                                self?.healthPic.append(category.img_name)
                            case "6":
                                self?.tool.append(category.title)
                                self?.toolPic.append(category.img_name)
                                
                            default:
                                break
                            }
                        }
                        
                        self?.objects = [
                            categoryStruct(sectionName: "Digital", cellObjects: self!.digital, images: self!.digitalPic),
                            categoryStruct(sectionName: "Home Application", cellObjects: self!.home, images: self!.homePic),
                            categoryStruct(sectionName: "Health and hygeinic", cellObjects: self!.health, images:self!.healthPic),
                            categoryStruct(sectionName: "Clothes", cellObjects: self!.clothes, images: self!.clothesPic),
                            categoryStruct(sectionName: "Tools", cellObjects: self!.tool, images: self!.toolPic),
                            categoryStruct(sectionName: "Books", cellObjects: self!.book, images: self!.bookPic)
                           
                        ]
                        
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    
                }catch {
                    print("could not decode categories!")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return objects.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objects[section].cellObjects.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCategoryTableViewCell", for: indexPath) as! FirstCategoryTableViewCell
        cell.productName.text = objects[indexPath.section].cellObjects[indexPath.row]
        let route = "http://ioscode.freehost.io/DigikalaPhp/categoryImages/"
        let imageLink = route + objects[indexPath.section].images[indexPath.row]
        let url = URL(string: imageLink)
        cell.productImage.kf.setImage(with: url!)
        return cell
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objects[section].sectionName
    }
}
