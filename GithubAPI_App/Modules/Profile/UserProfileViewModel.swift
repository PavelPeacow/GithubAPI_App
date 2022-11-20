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
                repos = await getUserRepos(usernmame: user.login) ?? []
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
    
    private func getUserRepos(usernmame: String) async -> [Repo]? {
        do {
            let repos = try await APIManager.shared.getUserRepo(with: usernmame)
            print(repos)
            return repos
        } catch {
            print(error)
            return nil
        }
    }
    
}
