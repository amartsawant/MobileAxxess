//
//  PersistenceCoordinator.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 03/11/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import Foundation
import RealmSwift

final class PersistenceCoordinator {
    static let shared = PersistenceCoordinator()
    var dbInstance: Realm?
    
    private init(){
        do {
            self.dbInstance = try Realm()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func add(article: InfoItem) {
        do {
            try dbInstance?.write{
                dbInstance?.add(article)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addAll(articles: [InfoItem]) {
        do {
            dbInstance?.beginWrite()
            for article in articles {
                let alreadyExists = dbInstance?.object(ofType: InfoItem.self, forPrimaryKey: article.id)
                if alreadyExists == nil {
                    dbInstance?.add(article)
                }
            }
            try dbInstance?.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func allArticles() -> [InfoItem]? {
        if let dbInstance = dbInstance {
            return dbInstance.objects(InfoItem.self).toArray(ofType: InfoItem.self)
        }
        return nil
    }
    
    func removeAll() {
        if let dbInstance = dbInstance {
            do{
                let articles = dbInstance.objects(InfoItem.self)
                for article in articles {
                    try dbInstance.write{
                        dbInstance.delete(article)
                    }
                }
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for result in self {
            if let result = result as? T {
                array.append(result)
            }
        }
        return array
    }
}
