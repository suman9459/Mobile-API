//
//  DetailTableViewCell.swift
//  ScreeingTmobile
//
//  Created by sai suman Pothedar on 3/30/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit

class DetailTableViewCell: UITableViewCell {
    
    var repoName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var forkcount: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var starsCount: UILabel = {
           let label = UILabel()
           label.textAlignment = .right
           label.textColor = UIColor.black
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubViews()
        updateConstraintstoViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    private func addSubViews(){
        addSubview(repoName)
        addSubview(forkcount)
        addSubview(starsCount)
    }
    
    private func updateConstraintstoViews() {
        repoName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        repoName.topAnchor.constraint(equalTo: topAnchor, constant: contentView.frame.height/2).isActive = true
        repoName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        repoName.widthAnchor.constraint(equalToConstant: contentView.frame.width/2).isActive = true
        
        
        contentView.trailingAnchor.constraint(equalTo: forkcount.trailingAnchor, constant: 5).isActive = true
        forkcount.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        forkcount.heightAnchor.constraint(equalToConstant: 20).isActive = true
        forkcount.widthAnchor.constraint(equalToConstant: contentView.frame.width/2).isActive = true
        
        
        contentView.trailingAnchor.constraint(equalTo: starsCount.trailingAnchor, constant: 5).isActive = true
        starsCount.topAnchor.constraint(equalTo: forkcount.bottomAnchor, constant: 5).isActive = true
        starsCount.heightAnchor.constraint(equalToConstant: 20).isActive = true
        starsCount.widthAnchor.constraint(equalToConstant: contentView.frame.width/2).isActive = true
  
    }
    
    func updateCell(details: UserRepoDetails?) {
        if let name = details?.name {
            repoName.text = name
        }
        if let name = details?.forks {
            self.forkcount.text = String(name) + " Forks"
        }
        if let stars = details?.stargazers_count {
            self.starsCount.text = String(stars) + " Stars"
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

