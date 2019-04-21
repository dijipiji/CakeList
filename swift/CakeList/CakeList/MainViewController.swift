//
//  MainViewController.swift
//  CakeList
//
//  Created by Jamie Lemon on 19/04/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var LIST_DATA:[Any] = []
    var SOURCED_CELL_IMAGES:[UIImage?] = []
    
    /**
     *
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let success:Bool = startDataFetch()
        
        if success {
            self.tableView.reloadData()
        }
        
    }
    
    /**
     *
     */
    func startDataFetch() -> Bool {
        
        let data:Data? = CakeData.getData()
        
        if data == nil {
            
        } else {
            let json:Any? = CakeData.parseData(data!)
            
            if json != nil {
                
                LIST_DATA = json! as! [Any]
                
                for _ in LIST_DATA {
                    SOURCED_CELL_IMAGES.append(nil)
                }
                
            }
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
         return LIST_DATA.count
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
        
        let object:[String:String] = LIST_DATA[indexPath.row] as! [String:String]
        cell.textLabel!.text = object["title"]
        cell.detailTextLabel!.text = object["desc"]
        cell.imageView!.image = getDefaultCakeImage()
        
        let url:URL! = URL(string:object["image"]!)
        let request:URLRequest = URLRequest(url: url!)
        
        if SOURCED_CELL_IMAGES[indexPath.row] == nil {
            let task = URLSession.shared.dataTask(with: request,
                                                  completionHandler: {data, response, error -> Void in
                                                    
                                                    if error == nil {
                                                        
                                                        var image:UIImage? = UIImage(data: data!)
                                                        
                                                        if image == nil {
                                                            image = self.getDefaultCakeImage()
                                                        }
                                                        
                                                        self.SOURCED_CELL_IMAGES[indexPath.row] = image
                                                        
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
            cell.imageView!.image = SOURCED_CELL_IMAGES[indexPath.row]!
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

