//
//  APIManager.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 17.11.2022.
//

import Foundation

protocol NetworkLayerProtocol {
    func getGithubContent<T: Decodable>(returnType: T.Type, endpoint: Endpoint) async throws -> T
}

enum APIError: Error {
    case badURL
    case badRequest
    case canNotGetData
    case canNotDecode
}

extension NetworkLayer {
    static private let accessTokenKey = "accessToken"
    
    var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: NetworkLayer.accessTokenKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: NetworkLayer.accessTokenKey)
        }
    }
}

final class NetworkLayer: NetworkLayerProtocol {
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = .init()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func getGithubContent<T: Decodable>(returnType: T.Type, endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else { throw APIError.badURL }
        guard let request = endpoint.getRequest(url: url) else { print(APIError.badRequest); throw APIError.badRequest }
       
        guard let (data, _) = try? await urlSession.data(for: request) else { print(APIError.canNotGetData); throw APIError.canNotGetData }
        
        guard let result = try? jsonDecoder.decode(T.self, from: data) else { print(APIError.canNotDecode); throw APIError.canNotDecode }
        print(result)
                
        if let token = result as? Token {
            accessToken = token.access_token
        }
        
        return result
    }
}
