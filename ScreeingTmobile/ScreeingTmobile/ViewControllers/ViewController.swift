//
//  ViewController.swift
//  ScreeingTmobile
//
//  Created by sai suman Pothedar on 3/30/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit

protocol FirstVCProtocol {
    func getdata(feed: FeedModel)
}

class ViewController: UIViewController {
    
    let tableviewCellIdentifier = "albumcell"
    weak var progress: UIActivityIndicatorView!
    var feed: FeedModel?
    let viewModel = FirstVCViewModel()
    
    var tableView: UITableView = {
        let tablveiw = UITableView()
        tablveiw.translatesAutoresizingMaskIntoConstraints = false
        return tablveiw
    }()
    
    var textFeild: UITextField = {
        let textfeild = UITextField()
        textfeild.layer.cornerRadius = 9.0
        textfeild.layer.borderWidth = 1.0
        textfeild.layer.borderColor = UIColor.black.cgColor
        textfeild.translatesAutoresizingMaskIntoConstraints = false
        textfeild.placeholder = "Search for Users"
        textfeild.selectAll(nil)
        return textfeild
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewsandConstraints()
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        textFeild.delegate = self
        viewModel.getUsersList(query: "")
        registerTableViewCell()
    }
    
    // register for TableviewCell
    private func registerTableViewCell() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: tableviewCellIdentifier)
    }
    
    func addViewsandConstraints() {
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(textFeild)
        self.view.addSubview(tableView)
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textFeild.leftView = paddingView
        textFeild.leftViewMode = .always
        
        textFeild.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        textFeild.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.view.trailingAnchor.constraint(equalTo: self.textFeild.trailingAnchor, constant: 20).isActive = true
        textFeild.heightAnchor.constraint(equalToConstant: 40).isActive = true

        tableView.topAnchor.constraint(equalTo: self.textFeild.bottomAnchor, constant: 5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 5).isActive = true
    }
}

extension ViewController: FirstVCProtocol {
    // getting responce from viewModel
    func getdata(feed: FeedModel) {
        self.feed = feed
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = feed?.items?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableviewCellIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        if let result = feed?.items?[indexPath.row] {
            cell.updateData(result: result)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let detailVC = DetailsViewController()
        detailVC.url = feed?.items?[indexPath.row].url
        self.navigationController?.pushViewController(detailVC, animated: false)
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var searchStr = textField.text ?? ""
        searchStr.append(string)
        viewModel.getUsersList(query: searchStr)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
