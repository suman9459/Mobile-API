//
//  FirstVCViewModel.swift
//  ScreeingTmobile
//
//  Created by sai suman Pothedar on 3/30/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation

class FirstVCViewModel: NSObject {
    
    var delegate: FirstVCProtocol?
    
    // get users List
    func getUsersList(query: String) {
        let trimmedquery = query.trimmingCharacters(in: .newlines).trimmingCharacters(in: .whitespaces)
        let baseurl = Constants.usersBaseUrl + trimmedquery
        NetWorkManager.shared().getData(url: baseurl) { (data) in
            let jsonDecode = JSONDecoder()
            do {
                let feeddata = try jsonDecode.decode(FeedModel.self, from: data)
                self.delegate?.getdata(feed: feeddata)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
}
