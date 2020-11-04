//
//  ViewController.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 31/10/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var viewModel: ArticlesViewModel?
    var refreshControl = UIRefreshControl()
    
    let tableview: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel = ArticlesViewModel(dataHandler: DataManager.shared)
        self.title = viewModel?.titleForView()
        configureTableViewViewComponents()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableview.refreshControl = refreshControl
        
        if let viewModel = viewModel {
            viewModel.fetchArticlesData { (error) in
                if let _ = error {
                    //handle error displaying alert
                    self.showAlert(title: "Error", message: "Error in loading data.\n Please try again later")
                }else {
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }
            }
        }else {
            assertionFailure("view model not assigned")
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        fetchArticles()
    }
    
    func fetchArticles() {
        if let viewModel = viewModel {
            viewModel.fetchArticlesData { (error) in
                
                DispatchQueue.main.async {
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                }
                if let _ = error {
                    //handle error displaying alert
                    self.showAlert(title: "Error", message: "Error in loading data.\n Please try again later")
                }else {
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }
            }
        }
    }
    
    func configureTableViewViewComponents() {
        // register tableview cell
        tableview.register(ArticleTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
        //setup tableview
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { snap in
            snap.edges.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let article = viewModel?.articles?[indexPath.row] {
            let articleDetailViewController = DetailViewController(article: article)
            self.navigationController?.pushViewController(articleDetailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! ArticleTableViewCell
        
        if let article = viewModel?.articles?[indexPath.row] {
            if article.type == "text" {
                cell.descriptionLabel.text = article.data
                cell.articleImageView.isHidden = true
            }else {
                let image = ImageManager.shared.imageForUrl(article.data)
                cell.articleImageView.image = image
                cell.articleImageView.isHidden = false
                cell.descriptionLabel.text = nil
            }
            cell.dateLabel.text = article.date
        }
        
        cell.backgroundColor = .white
        return cell
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Approve", style: .default, handler: { _ in
            print("User click Approve button")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
