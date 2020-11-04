//
//  ArticleViewModelTests.swift
//  MobileAxxessTests
//
//  Created by Amar Sawant on 04/11/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import XCTest
@testable import MobileAxxess

class ArticleViewModelTests: XCTestCase {
    private var dataManager: DataManager?
    private let url = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    private var articles: [InfoItem]?
    private var viewModel: ArticlesViewModel?
    
    override func setUpWithError() throws {
        let info1 = InfoItem()
        info1.id = "111"
        info1.type = "text"
        info1.data = "test text"
        info1.date = "2/22/2020"
        
        let info2 = InfoItem()
        info2.id = "222"
        info2.type = "text"
        info2.data = "test text 2"
        info2.date = "1/21/2020"
        
        let info3 = InfoItem()
        info3.id = "333"
        info3.type = "image"
        info3.data = "https://placeimg.com/620/320/any"
        info3.date = "9/4/2015"
        
        articles = [info1, info2, info3]
        
        viewModel = ArticlesViewModel(dataHandler:DataManager.shared)
        viewModel?.articles = articles
    }
    
    override func tearDownWithError() throws {
    }
    
    func testNumberOfArticles() {
        let count = viewModel?.numberOfArticles()
        XCTAssertEqual(count, 3)
    }
    
    func testSortArticles() {
        let sortedArray = viewModel?.sortArticles(articles: articles ?? [])
        viewModel?.articles = sortedArray
        XCTAssertNotNil(sortedArray)
        XCTAssertEqual(sortedArray?.count, 3)
        XCTAssertEqual(viewModel?.articleAtIndex(0)?.type, "image")
    }
}
