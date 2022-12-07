//
//  UserProfileViewModel.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import Foundation
import SafariServices

final class UserProfileViewModel {
    
    var user: User!
    var isAuthUser = false
    
    func loadRepos(isAuthUser: Bool, onCompletion: @escaping ([Repo]) -> Void) {
        Task {
            var repos: [Repo]
            
            if isAuthUser {
                repos = await getProfileRepos() ?? []
            } else {
                repos = await getUserRepos() ?? []
            }
            
            onCompletion(repos)
        }
    }
    
    private func getProfileRepos() async -> [Repo]? {
        try? await NetworkLayer().getGithubContent(returnType: [Repo].self, endpoint: .getAuthUserRepos)
    }
    
    private func getUserRepos() async -> [Repo]? {
        try? await NetworkLayer().getGithubContent(returnType: [Repo].self, endpoint: .getUserRepos(username: user.login))
    }
    
    func getUserFollowers() async -> [User]? {
        try? await NetworkLayer().getGithubContent(returnType: [User].self, endpoint: .getUserFollowers(username: user.login))
    }
    
    func getUserFollowing() async -> [User]? {
        try? await NetworkLayer().getGithubContent(returnType: [User].self, endpoint: .getUserFollowing(username: user.login))
        
    }
    
    func didTapShowInGithubButton() -> SFSafariViewController? {
        if let url = URL(string: user.html_url ?? "") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            return vc
        }
        return nil
    }
    
    func logout() {
        NetworkLayer().accessToken = nil
    }
    
}
