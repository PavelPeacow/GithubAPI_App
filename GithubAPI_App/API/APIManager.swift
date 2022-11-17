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
    
    private let accessTokenKey = "accessToken"
    
    private let clientID = "7968bef2c624696f25e8"
    private let clientSecret = "1ebbfea49625b6161f07debba5319a81c3364524"
    
    var accessToken: String? {
      get {
        UserDefaults.standard.string(forKey: accessTokenKey)
      }
      set {
        UserDefaults.standard.setValue(newValue, forKey: accessTokenKey)
      }
    }
    
    static let shared = APIManager()
    
    func getUserToken(with code: String) async throws {
        guard let url = URL(string: "https://github.com/login/oauth/access_token?client_id=\(clientID)&client_secret=\(clientSecret)&code=\(code)") else { throw APIError.badURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let (data, _) = try? await URLSession.shared.data(for: request) else { throw APIError.canNotGetData }
        
        guard let result = try? JSONDecoder().decode(Token.self, from: data) else { throw APIError.canNotDecode}
        print(result)
        
        accessToken = result.access_token
        
    }
        
    func getRepo(with token: String) async throws -> [Repo] {
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
