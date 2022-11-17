//
//  APIManager.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 17.11.2022.
//

import Foundation

enum APIError: Error {
    case badURL
    case canNotGetData
    case canNotDecode
}

final class APIManager {
    
    static let shared = APIManager()
    
    private let token = "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"
    
    func getRepo() async throws -> [Repo] {
        guard let url = URL(string: "https://api.github.com/user/repos") else { throw APIError.badURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let (data, _) = try? await URLSession.shared.data(for: request) else { throw APIError.canNotGetData }
        
        guard let result = try? JSONDecoder().decode([Repo].self, from: data) else { throw APIError.canNotDecode}
        print(result)
        
        return result
    }
    
}