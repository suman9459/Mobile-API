//
//  DetailsViewController.swift
//  ScreeingTmobile
//
//  Created by sai suman Pothedar on 3/30/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit

protocol DetaiVCProtocol {
    func getImage(image: UIImage)
    func getUserInfo(userInfo: UserDetails)
    func getRepository(listofrepos: [UserRepoDetails])
}

class DetailsViewController: UIViewController {
    
    var tableView: UITableView = {
        let tablveiw = UITableView()
        tablveiw.translatesAutoresizingMaskIntoConstraints = false
        return tablveiw
    }()
    
    var userName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var joinDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var followsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var followersLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "This is their Boigraphy. It may be long and need to all fit"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: label.font.fontName, size: 13)
        return label
    }()
    
    var thumImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var textFeild: UITextField = {
        let textfeild = UITextField()
        textfeild.layer.cornerRadius = 9.0
        textfeild.layer.borderWidth = 1.0
        textfeild.layer.borderColor = UIColor.black.cgColor
        textfeild.translatesAutoresizingMaskIntoConstraints = false
        textfeild.placeholder = "  Search for User's Repositories"
        return textfeild
    }()
    
    var userDetails: UserDetails?
    var listofrepos: [UserRepoDetails]?
    var filtedrepos: [UserRepoDetails]?
    var viewModel = DetailViewModel()
    let tableviewCellIdentifier = "GenresCell"
    var container:UIView?
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        addSubviews()
        registerTablview()
        
        if let userdetailPath = url {
            viewModel.getUserDetails(url: userdetailPath)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func addSubviews(){
        
        container = UIView(frame: view.frame)
        container?.backgroundColor = UIColor.white
        textFeild.delegate = self
        if let contentView = container {
            self.view.addSubview(contentView)
            
            contentView.addSubview(thumImageView)
            contentView.addSubview(userName)
            contentView.addSubview(emailLabel)
            contentView.addSubview(locationLabel)
            contentView.addSubview(joinDateLabel)
            contentView.addSubview(followersLabel)
            contentView.addSubview(followsLabel)
            contentView.addSubview(bioLabel)
            contentView.addSubview(textFeild)
            contentView.addSubview(tableView)
            updateConstainst(containerView: contentView)
            let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            textFeild.leftView = paddingView
        }
        
    }
    
    private func updateConstainst(containerView: UIView) {
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        
        
        thumImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 130).isActive = true
        thumImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        thumImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        thumImageView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        userName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100).isActive = true
        userName.leadingAnchor.constraint(equalTo: thumImageView.trailingAnchor, constant: 10).isActive = true
        userName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        containerView.trailingAnchor.constraint(equalTo: userName.trailingAnchor, constant: 20).isActive = true
        
        
        emailLabel.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: thumImageView.trailingAnchor, constant: 10).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        containerView.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 20).isActive = true
        
        
        locationLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: thumImageView.trailingAnchor, constant: 10).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        containerView.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 20).isActive = true
        
        joinDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5).isActive = true
        joinDateLabel.leadingAnchor.constraint(equalTo: thumImageView.trailingAnchor, constant: 10).isActive = true
        joinDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        containerView.trailingAnchor.constraint(equalTo: joinDateLabel.trailingAnchor, constant: 20).isActive = true
        
        followersLabel.topAnchor.constraint(equalTo: joinDateLabel.bottomAnchor, constant: 5).isActive = true
        followersLabel.leadingAnchor.constraint(equalTo: thumImageView.trailingAnchor, constant: 10).isActive = true
        followersLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        containerView.trailingAnchor.constraint(equalTo: followersLabel.trailingAnchor, constant: 20).isActive = true
        
        followsLabel.topAnchor.constraint(equalTo: followersLabel.bottomAnchor, constant: 5).isActive = true
        followsLabel.leadingAnchor.constraint(equalTo: thumImageView.trailingAnchor, constant: 10).isActive = true
        followsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        containerView.trailingAnchor.constraint(equalTo: followsLabel.trailingAnchor, constant: 20).isActive = true
        
        
        bioLabel.topAnchor.constraint(equalTo: followsLabel.bottomAnchor, constant: 5).isActive = true
        bioLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bioLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 20))
        textFeild.leftView = paddingView
        textFeild.leftViewMode = .whileEditing
        
        textFeild.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: textFeild.trailingAnchor, constant: 20).isActive = true
        textFeild.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        textFeild.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        tableView.topAnchor.constraint(equalTo: textFeild.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    // register for TableviewCell
    private func registerTablview() {
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: tableviewCellIdentifier)
    }
    
    // updating  UI feilds
    func updateUI() {
        if let detailData = userDetails {
            if let url = detailData.avatar_url {
                viewModel.downloadImage(url: url)
            }
            userName.text = detailData.name ?? ""
            emailLabel.text = detailData.email ?? "--@gmail.com"
            locationLabel.text = detailData.location ?? "--"
            joinDateLabel.text = detailData.created_at ?? ""
            followsLabel.text = String(detailData.followers ?? 0) + " Followers"
            followersLabel.text = "Following " + String(detailData.following ?? 0)
        }
    }
}

extension DetailsViewController: DetaiVCProtocol {
    
    // getting downoaded image from Viewmodel
    func getImage(image: UIImage) {
        DispatchQueue.main.async {
            self.thumImageView.contentMode = .scaleAspectFit
            self.thumImageView.layer.cornerRadius = 6.0
            self.thumImageView.layer.masksToBounds = true
            self.thumImageView.image = image
        }
    }
    
    func getUserInfo(userInfo: UserDetails) {
        userDetails = userInfo
        DispatchQueue.main.async {
            self.updateUI()
        }
        if let imageurl = userInfo.avatar_url {
            viewModel.downloadImage(url: imageurl)
        }
        if let repos_url = userInfo.repos_url {
            viewModel.getUserRepositories(url: repos_url)
        }
    }
    
    func getRepository(listofrepos: [UserRepoDetails]) {
        filtedrepos = listofrepos
        self.listofrepos = listofrepos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = filtedrepos?.count {
            return count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableviewCellIdentifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
        cell.updateCell(details: filtedrepos?[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let url = URL(string: filtedrepos?[indexPath.row].html_url ?? "") else { return }
        UIApplication.shared.open(url)
        
    }
}

extension DetailsViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var searchStr = textField.text ?? ""
        searchStr.append(string)
        let trimmedstr = searchStr.lowercased().trimmingCharacters(in: .whitespaces)
        DispatchQueue.main.async {
            if string.isEmpty  {
                self.filtedrepos = self.listofrepos
            } else {
                self.filtedrepos = self.listofrepos?.filter({$0.name?.hasPrefix(trimmedstr) == true})
            }
            self.tableView.reloadData()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
