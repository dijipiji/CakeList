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
        
    }
    
    /**
     *
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /**
     *
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "CakeCell")
        
        cell.imageView!.image = UIImage(named:"icon-cake")!
        cell.textLabel!.text = "Title"
        
        cell.detailTextLabel!.text = "Subtitle"
        
        return cell
    }


}

