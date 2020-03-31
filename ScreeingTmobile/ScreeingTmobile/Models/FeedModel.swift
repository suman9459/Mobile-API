//
//  FeedModel.swift
//  ScreeingTmobile
//
//  Created by sai suman Pothedar on 3/30/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation

struct FeedModel: Decodable {
    //let feed: feed?
    let items: [item]?
}

struct feed: Decodable {
    let items: [item]?
}
struct item: Decodable {
    let login: String
    let avatar_url: String
    let repos_url: String
    let url: String
    
}

struct UserDetails: Decodable {
    let login: String?
    let name: String?
    let created_at: String?
    let avatar_url: String?
    let followers: Int?
    let following: Int?
    let location: String?
    let email: String?
    let repos_url: String?
}
struct UserRepoDetails: Decodable {
    let full_name: String?
    let forks: Int?
    let name: String?
    let stargazers_count: Int?
    let html_url: String
}
