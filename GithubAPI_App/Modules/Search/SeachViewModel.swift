//
//  SeachViewModel.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 27.11.2022.
//

import Foundation

final class SearchViewModel {
    
    func getUser(username: String) async -> User? {
        do {
            let result = try await NetworkLayer().getGithubContent(returnType: User.self, endpoint: .getUserProfile(username: username))
            return result
        } catch {
            print(error)
            return nil
        }
        
    }
}
