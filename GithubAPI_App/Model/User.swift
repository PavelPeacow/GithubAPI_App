//
//  User.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 19.11.2022.
//

import Foundation

struct User: Decodable {
    let login: String
    let avatar_url: String
    let bio: String?
    let public_repos: Int?
    let name: String?
    let location: String?
    let followers: Int?
    let following: Int?
}
