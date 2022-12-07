//
//  RepoContentViewModel.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 27.11.2022.
//

import Foundation

final class RepoContentViewModel {
    
    var repoContent = [RepoContent]()
    var username = ""
    var repoName = ""
    
    func getRepoContent(username: String, repoName: String, path: String) async -> [RepoContent]? {
        try? await NetworkLayer().getGithubContent(returnType: [RepoContent].self, endpoint: .getRepoContent(owner: username, repositoryName: repoName, path: path))
        
    }
    
    func getRepoContentSingle(username: String, repoName: String, path: String) async -> RepoContent? {
        try? await NetworkLayer().getGithubContent(returnType: RepoContent.self, endpoint: .getRepoContent(owner: username, repositoryName: repoName, path: path))
        
    }
    
}
