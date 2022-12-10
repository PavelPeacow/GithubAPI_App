//
//  SeachViewModel.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 27.11.2022.
//

import Foundation

final class SearchViewModel {
    
    var users = [User]()
    
    func searchForUser(username: String, page: String) async -> UserSearch? {
        try? await NetworkLayer().getGithubContent(returnType: UserSearch.self, endpoint: .searchUser(username: username, page: page))
    }
    
    func getUser(username: String) async -> User? {
        try? await NetworkLayer().getGithubContent(returnType: User.self, endpoint: .getUserProfile(username: username))
    }
}
