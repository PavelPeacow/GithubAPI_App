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
        do {
            let repos = try await NetworkLayer().getGithubContentWithAuthToken(returnType: [Repo].self, endpoint: .getAuthUserRepos)
            print(repos)
            return repos
        } catch {
            print(error)
            return nil
        }
    }
    
    private func getUserRepos() async -> [Repo]? {
        do {
            let repos = try await NetworkLayer().getGithubContentProfileRelated(returnType: [Repo].self, endpoint: .getUserRepos(username: user.login))
            print(repos)
            return repos
        } catch {
            print(error)
            return nil
        }
    }
    
    func getUserFollowers() async -> [User]? {
        do {
            let users = try await NetworkLayer().getGithubContentProfileRelated(returnType: [User].self, endpoint: .getUserFollowers(username: user.login))
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
    func getUserFollowing() async -> [User]? {
        do {
            let users = try await NetworkLayer().getGithubContentProfileRelated(returnType: [User].self, endpoint: .getUserFollowing(username: user.login))
            return users
        } catch {
            print(error)
            return nil
        }
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
