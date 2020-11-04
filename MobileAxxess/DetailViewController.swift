//
//  DetailViewController.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 03/11/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    var viewModel: ArticleDetailViewModel?
    
    init(article: InfoItem) {
        viewModel = ArticleDetailViewModel(article: article)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var articleImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: ""))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        
        if let viewModel = viewModel {
            self.title = viewModel.titleForView()
        }else {
            assertionFailure("view model not assigned")
        }
    }
    
    func configureViewComponents() {
        //configure ui components
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { snap in
            snap.edges.equalToSuperview()
        }
        
        if let viewModel = viewModel {
            switch viewModel.articleType() {
            case .image:
                //setup ui for image
                scrollView.addSubview(articleImageView)
                scrollView.delegate = self
                
                articleImageView.snp.makeConstraints { snap in
                    snap.width.equalToSuperview()
                    snap.centerY.equalTo(self.view)
                }
                
            case .text:
                //setup ui for text
                let contentView = UIView()
                scrollView.addSubview(contentView)
                descriptionLabel.text = viewModel.articleDescription()
                contentView.addSubview(descriptionLabel)
                
                contentView.snp.makeConstraints { snap in
                    snap.top.bottom.equalTo(scrollView)
                    snap.left.right.equalTo(view)
                }
                
                descriptionLabel.snp.makeConstraints { snap in
                    snap.left.right.equalTo(contentView).inset(20)
                    snap.top.bottom.equalTo(contentView).offset(20)
                }
                
            default:
                //display alert
                print("")
            }
        }
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if let image =  viewModel?.imageForArticle() {
            articleImageView.image = image
            return articleImageView
        }
        return nil
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        articleImageView.snp.makeConstraints { snap in
            snap.width.equalToSuperview()
            snap.centerY.equalTo(self.view)
        }
        
    }
}
