//
//  NetworkConstant.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 27.11.2022.
//

import Foundation

final class NetworkConstant {
    static let clientID = "7968bef2c624696f25e8"
    static let clientSecret = "1ebbfea49625b6161f07debba5319a81c3364524"
    
    static let oauth = "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=read:user&scope=repo&state=TEST_STATE"
    static let callBackScheme = "pavel.github.test.app"
}
