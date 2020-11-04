//
//  ImageDownloder.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 02/11/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import Foundation

final class ImageDownloder: AsyncOperation {
    var completionHandler: (Data?, Error?) -> Void
    let serviceManager = ServiceManager()
    private let imageUrl: String

    init(imageUrl: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        self.completionHandler = completionHandler
        self.imageUrl = imageUrl
    }

    override func main() {
        print("start fetch image url: \(imageUrl)")
        
        serviceManager.fetchRemoteData(from: imageUrl) { (data, err) in
            
             if let error = err {
                print("Failed fetch image url: \(self.imageUrl)")
                self.completionHandler(nil, error)
                 return
             }
             
             if let data = data {
                print("success fetch image url: \(self.imageUrl)")
                self.completionHandler(data, nil)
             }
             self.finish()
         }
    }

    override func cancel() {
        super.cancel()
    }
}
