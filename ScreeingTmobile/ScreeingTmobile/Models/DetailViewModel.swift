//
//  DetailViewModel.swift
//  ScreeingTmobile
//
//  Created by sai suman Pothedar on 3/30/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation

class DetailViewModel: NSObject {
    var delegate: DetaiVCProtocol?
    
    // download Image
    func downloadImage(url: String) {
        NetWorkManager.shared().downloadImage(imageUrl: url) { (image) in
            self.delegate?.getImage(image: image)
        }
    }
    
    func getUserDetails(url: String) {
        NetWorkManager.shared().getData(url: url) { (data) in
            let jsonDecode = JSONDecoder()
            do {
                let feeddata = try jsonDecode.decode(UserDetails.self, from: data)
                self.delegate?.getUserInfo(userInfo: feeddata)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getUserRepositories(url: String){
        NetWorkManager.shared().getData(url: url) { (data) in
            let jsonDecode = JSONDecoder()
            do {
                let feeddata = try jsonDecode.decode([UserRepoDetails].self, from: data)
                self.delegate?.getRepository(listofrepos: feeddata)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
