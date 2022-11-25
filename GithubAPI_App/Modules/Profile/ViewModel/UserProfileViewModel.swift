//
//  UserProfileViewModel.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import Foundation

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
            let repos = try await APIManager.shared.getGithubContentWithAuthToken(returnType: [Repo].self, endpoint: .getAuthUserRepos)
            print(repos)
            return repos
        } catch {
            print(error)
            return nil
        }
    }
    
    private func getUserRepos() async -> [Repo]? {
        do {
            let repos = try await APIManager.shared.getGithubContentProfileRelated(returnType: [Repo].self, endpoint: .getUserRepos(username: user.login))
            print(repos)
            return repos
        } catch {
            print(error)
            return nil
        }
    }
    
    func getUserFollowers() async -> [User]? {
        do {
            let users = try await APIManager.shared.getGithubContentProfileRelated(returnType: [User].self, endpoint: .getUserFollowers(username: user.login))
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
    func getUserFollowing() async -> [User]? {
        do {
            let users = try await APIManager.shared.getGithubContentProfileRelated(returnType: [User].self, endpoint: .getUserFollowing(username: user.login))
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
    func logout() {
        APIManager.shared.accessToken = nil
    }
    
}
