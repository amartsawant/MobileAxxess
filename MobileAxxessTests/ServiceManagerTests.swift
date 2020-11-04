//
//  ServiceManagerTests.swift
//  MobileAxxessTests
//
//  Created by Amar Sawant on 04/11/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import XCTest
@testable import MobileAxxess

class ServiceManagerTests: XCTestCase {
    private var serviceManager: ServiceManager?
    private let url = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    
    override func setUpWithError() throws {
        serviceManager = ServiceManager()
    }
    
    override func tearDownWithError() throws {
    }
    
    func testRemoteCall() {
        let expectation = self.expectation(description: "Error recieving response")
        
        if let serviceManager = self.serviceManager {
            serviceManager.fetchRemoteData(from: url) { (data, error) in
                if error != nil{
                    XCTFail("Test Failed: call to fetchRemoteData")
                }
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
