//
//  Endpoint.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 27.11.2022.
//

import Foundation

protocol EndpointProtocol {
    var url: URL? { get }
    var httpMethod: HTTPMethod { get }
    func getRequest(url: URL?) -> URLRequest?
    func urlComponents(scheme: String, host: String, path: String, quertyItems: [URLQueryItem]?) -> URL?
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Endpoint: EndpointProtocol {
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
                URLQueryItem(name: "client_id", value: "\(NetworkConstant.clientID)"),
                URLQueryItem(name: "client_secret", value: "\(NetworkConstant.clientSecret)"),
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
        case .getAuthUser, .getAuthUserRepos, .getRepoContent,
                .getUserProfile, .getUserRepos, .getUserFollowing,
                .getUserFollowers:
            return .get
        }
    }
    
    func getRequest(url: URL?) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        switch self {
        case .getUserToken:
            request.httpMethod = httpMethod.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        case .getAuthUser, .getRepoContent, .getAuthUserRepos:
            request.httpMethod = httpMethod.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(NetworkLayer().accessToken ?? "")", forHTTPHeaderField: "Authorization")
        case .getUserProfile, .getUserRepos, .getUserFollowing, .getUserFollowers:
            request.httpMethod = httpMethod.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    func urlComponents(scheme: String = "https", host: String = "api.github.com", path: String, quertyItems: [URLQueryItem]? = [URLQueryItem(name: "per_page", value: "100")]) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = quertyItems
        return components.url
    }
}
