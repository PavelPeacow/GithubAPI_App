//
//  RepoContent.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 23.11.2022.
//

import Foundation

struct RepoContent: Decodable {
    let name: String?
    let path: String?
    let content: String?
    let type: String?
}
