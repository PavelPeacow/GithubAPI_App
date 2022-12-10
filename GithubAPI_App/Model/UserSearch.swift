//
//  UserSearch.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 10.12.2022.
//

import Foundation

struct UserSearch: Decodable {
    let total_count: Int
    let items: [User]
}
