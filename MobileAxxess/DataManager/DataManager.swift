//
//  DataManager.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 31/10/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    let serviceManager = ServiceManager()
    let dataCoordinator = PersistenceCoordinator.shared
    let network = NetworkManager.sharedInstance
    
    private init() {
    }
    
    func fetchArticles(completion: @escaping ([InfoItem]?, Error?) -> ()) {
        
        NetworkManager.isUnreachable {_ in
            completion(self.dataCoordinator.allArticles(), nil)
        }
        
        NetworkManager.isReachable {_ in
            self.serviceManager.fetchRemoteData(from: "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json") { (data, err) in
                
                if let error = err {
                    completion(nil, error)
                    return
                }
                
                if let data = data {
                    if let parsedArray = self.parseJsonData(data: data) {
                        self.dataCoordinator.removeAll()
                        self.dataCoordinator.addAll(articles: parsedArray)
                        completion(parsedArray, nil)
                    }
                }
            }
        }
    }
    
    func parseJsonData(data: Data) -> [InfoItem]? {
        let decoder = JSONDecoder()
        do {
            let articles = try decoder.decode([InfoItem].self, from: data)
            return articles
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
