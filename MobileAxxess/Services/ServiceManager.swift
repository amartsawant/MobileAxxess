//
//  ServiceManager.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 31/10/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import Alamofire

class ServiceManager {
    
    func fetchRemoteData(from url: String, completion: @escaping (Data?, Error?) -> ()) {
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseData{ response in
                        
            switch response.result {
            case .success(let value):
                completion(value, nil)
                
            case .failure(let error):
                completion(nil, error as NSError?)
                
            }
        }
    }
}
