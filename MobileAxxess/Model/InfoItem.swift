//
//  InfoItem.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 31/10/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import RealmSwift

class InfoItem: Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var type: String?
    @objc dynamic var data: String?
    @objc dynamic var date: String?
    
    override static func primaryKey() -> String? {
        return "id"
    } 
}
