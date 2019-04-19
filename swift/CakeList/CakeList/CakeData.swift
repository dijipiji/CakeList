//
//  CakeData.swift
//  CakeList
//
//  Created by Jamie Lemon on 19/04/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class CakeData: NSObject {
    
    /**
     *
     */
    public class func getData() -> Data? {
        
        let url:URL = URL(string: "https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json")!
        
        if let data:Data = try? Data.init(contentsOf: url) { return data }
        
        return nil
    }
    
    
    /**
     *
     */
    public class func parseData(_ data:Data) -> Any? {
        
        do {
            let json:Any? = try JSONSerialization.jsonObject(with: data, options:[]) as Any?
            
            if json != nil {
                return json
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
        
        return nil
        
    }

}
