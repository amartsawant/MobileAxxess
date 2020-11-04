//
//  DataManagerTests.swift
//  MobileAxxessTests
//
//  Created by Amar Sawant on 04/11/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import XCTest
@testable import MobileAxxess

class DataManagerTests: XCTestCase {
    private var dataManager: DataManager?
    private let url = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    
    override func setUpWithError() throws {
        dataManager = DataManager.shared
    }
    
    override func tearDownWithError() throws {
    }
    
    func testRemoteCall() {
        let expectation = self.expectation(description: "Error while recieving response")
        
        if let dataManager = self.dataManager {
            dataManager.fetchArticles { (articles, error) in
                if error != nil{
                    XCTFail("Test Failed: call to fetchRemoteData")
                }
                XCTAssertNotNil(articles)
                XCTAssertEqual(articles?.count, 34)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
