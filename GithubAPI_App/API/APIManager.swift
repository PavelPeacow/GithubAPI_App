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
    
    let clientID = "7968bef2c624696f25e8"
    let clientSecret = "1ebbfea49625b6161f07debba5319a81c3364524"
    
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
    
    func getGithubContentWithAuthToken<T: Decodable>(returnType: T.Type, endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else { throw APIError.badURL }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        guard let (data, _) = try? await URLSession.shared.data(for: request) else { throw APIError.canNotGetData }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else { throw APIError.canNotDecode }
        print(result)
        
        
        return result
    }
    
    func getGithubContentProfileRelated<T: Decodable>(returnType: T.Type, endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else { throw APIError.badURL }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else { throw APIError.canNotGetData }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else { throw APIError.canNotDecode }
        print(result)
        
        return result
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Endpoint {
    case getUserToken(code: String)
    
    case getAuthUser
    case getAuthUserRepos
    
    case getRepoContent(owner: String, repositoryName: String, path: String?)
    
    case getUserProfile(username: String)
    case getUserRepos(username: String)
    case getUserFollowing(username: String)
    case getUserFollowers(username: String)
    
    var url: URL? {
        
        switch self {
            
        case .getUserToken(let code):
            
            let queryItems = [
                URLQueryItem(name: "client_id", value: "\(APIManager.shared.clientID)"),
                URLQueryItem(name: "clientSecret", value: "\(APIManager.shared.clientSecret)"),
                URLQueryItem(name: "code", value: code)
            ]
            return urlComponents(host: "github.com", path: "/login/oauth/access_token", quertyItems: queryItems)
            
        case .getAuthUser:
            
            return urlComponents(path: "/user")
            
        case .getAuthUserRepos:
            
            let queryItems = [
                URLQueryItem(name: "sort", value: "updated"),
                URLQueryItem(name: "per_page", value: "100")
            ]
            return urlComponents(path: "/user/repos", quertyItems: queryItems)
            
        case .getRepoContent(let owner, let repositoryName, let path):
            
            return urlComponents(path: "/repos/\(owner)/\(repositoryName)/contents/\(path ?? "")")
            
        case .getUserProfile(let username):
            
            return urlComponents(path: "/users/\(username)")
            
        case .getUserRepos(let username):
            
            let queryItems = [
                URLQueryItem(name: "sort", value: "updated"),
                URLQueryItem(name: "per_page", value: "100")
            ]
            return urlComponents(path: "/users/\(username)/repos", quertyItems: queryItems)
            
        case .getUserFollowers(let username):
            
            return urlComponents(path: "/users/\(username)/followers")
            
        case .getUserFollowing(let username):
            
            return urlComponents(path: "/users/\(username)/following")
            
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getUserToken:
            return .post
        case .getAuthUser:
            return .get
        case .getAuthUserRepos:
            return .get
        case .getRepoContent:
            return .get
        case .getUserProfile:
            return .get
        case .getUserRepos:
            return .get
        case .getUserFollowing:
            return .get
        case .getUserFollowers:
            return .get
        }
    }
    
    private func urlComponents(scheme: String = "https", host: String = "api.github.com", path: String, quertyItems: [URLQueryItem]? = [URLQueryItem(name: "per_page", value: "100")]) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = quertyItems
        return components.url
    }
}

