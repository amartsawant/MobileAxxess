//
//  ArticleTableViewCell.swift
//  MobileAxxess
//
//  Created by Amar Sawant on 01/11/20.
//  Copyright © 2020 atsawant.com. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.verticalStackView)
        verticalStackView.addArrangedSubview(articleImageView)
        verticalStackView.addArrangedSubview(descriptionLabel)
        verticalStackView.addArrangedSubview(dateLabel)
        
        container.snp.makeConstraints { snap in
            snap.top.bottom.equalTo(contentView).inset(7.5)
            snap.left.right.equalTo(contentView).inset(10)
        }
        
        verticalStackView.snp.makeConstraints { snap in
            snap.top.bottom.equalTo(container).inset(10)
            snap.left.right.equalTo(container).inset(10)
            snap.height.greaterThanOrEqualTo(50)
        }
        
        articleImageView.snp.makeConstraints { snap in
            snap.height.equalTo(200)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
