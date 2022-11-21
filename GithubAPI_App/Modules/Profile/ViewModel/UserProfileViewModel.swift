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
            let repos = try await APIManager.shared.getProfileRepo()
            print(repos)
            return repos
        } catch {
            print(error)
            return nil
        }
    }
    
    private func getUserRepos() async -> [Repo]? {
        do {
            let repos = try await APIManager.shared.getUserRepo(with: user.login)
            print(repos)
            return repos
        } catch {
            print(error)
            return nil
        }
    }
    
    func getUserFollowers() async -> [User]? {
        do {
            let users = try await APIManager.shared.getUserFollowers(with: user.login)
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
    func getUserFollowing() async -> [User]? {
        do {
            let users = try await APIManager.shared.getUserFollowing(with: user.login)
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
}
