//
//  RepoListViewModel.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 27.11.2022.
//

import Foundation

final class RepoListViewModel {
    
    var repos = [Repo]()
    var username = ""
    
    func getRepoContent(username: String, repoName: String, path: String?) async -> [RepoContent]? {
        try? await NetworkLayer().getGithubContent(returnType: [RepoContent].self, endpoint: .getRepoContent(owner: username, repositoryName: repoName, path: path))
    }
    
}
