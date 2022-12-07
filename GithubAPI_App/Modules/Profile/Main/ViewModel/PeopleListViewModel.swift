//
//  PeopleListViewModel.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 27.11.2022.
//

import Foundation

final class PeopleListViewModel {
    
    var users = [User]()
    
    func getUser(username: String) async -> User? {
        try? await NetworkLayer().getGithubContent(returnType: User.self, endpoint: .getUserProfile(username: username))
    }
}
