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
                
                //print("LIST_DATA=\(LIST_DATA)")
            }
        }
        
        return false
    }
    
    
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "CakeCell")
        
        let object:[String:String] = LIST_DATA[indexPath.row] as! [String:String]
        cell.textLabel!.text = object["title"]
        cell.detailTextLabel!.text = object["desc"]
        
        var image:UIImage!
        
        let url:URL! = URL(string:object["image"]!)

        if let data:Data = try? Data.init(contentsOf: url) {
            image = UIImage(data: data)
        }
        
        if image == nil {
            image = UIImage(named:"icon-cake")!
        }
        
        cell.imageView!.image = image
        
        return cell
    }


}

