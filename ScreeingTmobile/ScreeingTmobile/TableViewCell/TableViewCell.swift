//
//  TableViewCell.swift
//  ScreeingTmobile
//
//  Created by sai suman Pothedar on 3/30/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    var authorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var reposcount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    var thumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var index: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    func setupViews() {
        addSubview(thumImage)
        addSubview(authorName)
        addSubview(reposcount)
        addConstaints()
    }
    
    func addConstaints() {
        
        thumImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        contentView.bottomAnchor.constraint(equalTo: thumImage.bottomAnchor, constant: 10).isActive = true
        thumImage.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        thumImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        thumImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        authorName.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        authorName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        authorName.leadingAnchor.constraint(equalTo: thumImage.trailingAnchor, constant: 20).isActive = true
        
        contentView.trailingAnchor.constraint(equalTo: reposcount.trailingAnchor, constant: 5).isActive = true
        reposcount.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        reposcount.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(result: item) {
        authorName.text = result.login
        reposcount.text = "Repos: -- "
        if !result.avatar_url.isEmpty {
            NetWorkManager.shared().downloadImage(imageUrl: result.avatar_url) { (image) in
                DispatchQueue.main.async {
                    self.thumImage.layer.cornerRadius = 6.0
                    self.thumImage.layer.masksToBounds = true
                    self.thumImage.image = image
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
