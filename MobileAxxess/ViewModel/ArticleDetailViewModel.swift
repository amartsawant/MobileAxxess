//
//  ArticleDetailViewModel.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 02/11/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import Foundation
import UIKit

import Foundation

class ArticleDetailViewModel {
    var article: InfoItem?
    
    init(article: InfoItem) {
        self.article = article
    }
    
    func titleForView() -> String {
        return "Article"
    }
    
    func articleType() -> ArticleType {
        switch article?.type {
        case ArticleType.image.rawValue:
            return ArticleType.image
        case ArticleType.text.rawValue:
            return ArticleType.text
        default:
            return ArticleType.unknown
        }
    }
    
    func imageForArticle() -> UIImage {
        return ImageManager.shared.imageForUrl(article?.data)
    }
    
    func articleDescription() -> String? {
        return article?.data
    }
    
}
