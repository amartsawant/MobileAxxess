//
//  ImageManager.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 01/11/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    static let shared = ImageManager()
    let queue = OperationQueue()
    var downloadsInProgress = [String]()
    
    private init() {
    }
    
    func imageForUrl(_ url: String?) -> UIImage {
        
        guard let url = url  else {
            print("url string can not be nil")
            return UIImage.init(named: "placeholder.png")!
        }
        
        if let image = ImageCache.shared.cachedImageForUrl(url) {
            return image
        }else {
            fetchImage(for: url) { (data, error) in
                if let error = error {
                    print("\(error.localizedDescription)")
                    print("failed to download image for url : \(url)")
                }
                
                if let data = data {
                    //cache downloded image
                    if let image = UIImage.init(data: data) {
                        _ = ImageCache.shared.saveImageToCache(image, imageUrl: url)
                    }
                }
            }
            return UIImage.init(named: "preview.png")!
        }
    }
    
    func fetchImage(for url: String, completion: @escaping (Data?, Error?) -> ()) {
        
        if downloadsInProgress.contains(url) {
            print("downloading already in progress : \(url)")
            return
        }
        
        let imageDownloadOperation = ImageDownloder(imageUrl: url) { (data, err) in
            
            if let index = self.downloadsInProgress.firstIndex(of: url) {
                self.downloadsInProgress.remove(at: index)
            }
            
            if let error = err {
                print("Failed fetch image url: \(url)")
                completion(nil, error)
                return
            }
            
            if let data = data {
                print("success fetch image url: \(url)")
                completion(data, nil)
            }
            
        }
        downloadsInProgress.append(url)
        queue.addOperation(imageDownloadOperation)
    }
    
}
