//
//  CakeListTests.swift
//  CakeListTests
//
//  Created by Jamie Lemon on 19/04/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import XCTest
@testable import CakeList

class CakeListTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testData() {
        
        let cakeData:Data? = CakeData.getData()
        
        XCTAssert(cakeData != nil, "CakeData.getData() returns nil")
        
        let json:Any? = CakeData.parseData(cakeData!)
        
        XCTAssert(json != nil, "CakeData.parseData() returns nil")
        
        print("json=\(String(describing: json))")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
