//
//  ArticlesViewModel.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 02/11/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import Foundation

class ArticlesViewModel {
    var articles: [InfoItem]?
    let dataHandler: DataManager?
    
    init(dataHandler: DataManager) {
        self.dataHandler = dataHandler
    }
    
    func titleForView() -> String {
        return "Articles"
    }
    
    func sortArticles(articles: [InfoItem]) -> [InfoItem] {
        let array = articles.sorted { $0.type! < $1.type! }
        return array
    }
    
    func numberOfArticles() -> Int {
        return articles?.count ?? 0
    }
    
    func articleAtIndex(_ index: Int) -> InfoItem? {
        if let articles = articles, index < articles.count {
            return articles[index]
        }
        return nil
    }
    
    func fetchArticlesData(completion: @escaping (Error?) -> ()) {
        
        DataManager.shared.fetchArticles { (articles, error) in
            
            if let error = error {
                completion(error)
                return
            }
            
            if let articles = articles {
                self.articles = self.sortArticles(articles: articles)
                completion(nil)
            }
        }
    }
}
