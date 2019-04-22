//
//  MainViewController.swift
//  CakeList
//
//  Created by Jamie Lemon on 19/04/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    

    /**
     *
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let success:Bool = startDataFetch()
        
        if success {
            self.tableView.reloadData()
        } else {
            let uiAlertVC:UIAlertController = UIAlertController(title: NSLocalizedString("ERROR_TITLE", comment: ""),
                                                                message: NSLocalizedString("BAD_DATA_FETCH_MESSAGE", comment: ""),
                                                                preferredStyle: UIAlertController.Style.alert)
            let action:UIAlertAction = UIAlertAction(title:NSLocalizedString("OKAY", comment: ""), style:UIAlertAction.Style.default, handler:{ (myAlertAction: UIAlertAction!) in })
            
            uiAlertVC.addAction(action)
            self.present(uiAlertVC, animated: false, completion: nil)
        }
        
    }
    
    /**
     *
     */
    func startDataFetch() -> Bool {
        
        let data:Data? = CakeData.getData()
        
        if data != nil {
            let json:Any? = CakeData.parseData(data!)
            
            if json != nil {
                
                CakeData.LIST_DATA = json! as! [Any]
                
                for _ in CakeData.LIST_DATA {
                    CakeData.SOURCED_CELL_IMAGES.append(nil)
                }
                
            }
            
            return true
        }
        
        return false
    }
    
    /**
     *
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    /**
     *
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return CakeData.LIST_DATA.count
    }
    
    /**
     *
     */
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView!.image = getDefaultCakeImage()
    }
    
    /**
     *
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "CakeCell")
        
        let object:[String:String] = CakeData.LIST_DATA[indexPath.row] as! [String:String]
        cell.textLabel!.text = object["title"]
        cell.detailTextLabel!.text = object["desc"]
        cell.imageView!.image = getDefaultCakeImage()
        
        let url:URL! = URL(string:object["image"]!)
        let request:URLRequest = URLRequest(url: url!)
        
        if CakeData.SOURCED_CELL_IMAGES[indexPath.row] == nil {
            let task = URLSession.shared.dataTask(with: request,
                                                  completionHandler: {data, response, error -> Void in
                                                    
                                                    if error == nil {
                                                        
                                                        var image:UIImage? = UIImage(data: data!)
                                                        
                                                        if image == nil {
                                                            image = self.getDefaultCakeImage()
                                                        }
                                                        
                                                        CakeData.SOURCED_CELL_IMAGES[indexPath.row] = image
                                                        
                                                        // Update the cell on the main thread
                                                        DispatchQueue.main.async {
                                                            let cell:UITableViewCell? = tableView.cellForRow(at: indexPath)
                                                            
                                                            if cell != nil {
                                                                cell!.imageView!.image = image
                                                            }
                                                        }
                                                        
                                                    } else {
                                                        cell.imageView!.image = self.getDefaultCakeImage()
                                                    }
            })
            task.resume()
            
        } else {
            cell.imageView!.image = CakeData.SOURCED_CELL_IMAGES[indexPath.row]!
        }

        return cell
    }
    
    /**
     *
     */
    func getDefaultCakeImage() -> UIImage {
        return UIImage(named:"icon-cake")!
    }
    
}

