//
//  ImageCache.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 01/11/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import UIKit
import SwiftHash

class ImageCache {
    static let shared = ImageCache()
    
    private init() {
    }
    
    let directoryPath = {
        return NSHomeDirectory().appending("/Documents/ImageCache/")
    }()
    
    func cachedImageForUrl(_ url: String) -> UIImage? {
        return getImageFromDirectory(filePathForImage(at: url))
    }
    
    func saveImageToCache(_ image: UIImage, imageUrl: String) -> String? {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: directoryPath) {
            do {
                try fileManager.createDirectory(at: NSURL.fileURL(withPath: directoryPath), withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
        
        let imageName = MD5(imageUrl)
        let filename = imageName.appending(".jpg")
        let filepath = directoryPath.appending(filename)
        let url = NSURL.fileURL(withPath: filepath)
        do {
            try image.jpegData(compressionQuality: 1.0)?.write(to: url, options: .atomic)
            return directoryPath
        } catch {
            print(error)
            print("file cant not be save at path \(filepath), with error : \(error)");
            return nil
        }
    }
    
    func deleteDirectory(directoryName : String) {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(directoryName)
        if fileManager.fileExists(atPath: paths){
            try! fileManager.removeItem(atPath: paths)
        }else{
            print("Directory not found")
        }
    }
    
    func getImageFromDirectory(_ imagePath : String)-> UIImage? {
        let fileManager = FileManager.default
        // Here using getDirectoryPath method to get the Directory path
        if fileManager.fileExists(atPath: imagePath){
            return UIImage(contentsOfFile: imagePath)!
        }else{
            print("No Image available")
            return nil
        }
    }
    
    func filePathForImage(at url: String) -> String {
        let imageName = MD5(url)
        let filename = imageName.appending(".jpg")
        let filepath = directoryPath.appending(filename)
        return filepath
    }
    
}
