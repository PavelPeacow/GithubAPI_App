//
//  LoginViewModel.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import AuthenticationServices

final class LoginViewModel {
    
    func loadGitHubAuthPromt(in view: UIViewController, onCompleteion: @escaping (User?) -> Void) {
        guard let url = URL(string: "https://github.com/login/oauth/authorize?client_id=\(NetworkConstant.clientID)&scope=read:user&scope=repo&state=TEST_STATE") else { return }
        let callBackScheme = "pavel.github.test.app"
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callBackScheme) { callBackURL, error in
            guard let callBackURL = callBackURL, error == nil else { onCompleteion(nil); return}
            
            guard let query = URLComponents(string: callBackURL.absoluteString)?.queryItems else { onCompleteion(nil); return }
            guard let code = query.first(where: { $0.name == "code" } )?.value else { onCompleteion(nil); return }
            
            print(code)
            
            Task { [weak self] in
                await self?.getUserToken(code: code)
                if let user = await self?.getAuthUser() {
                    onCompleteion(user)
                }
                
            }
        }
        session.presentationContextProvider = view as? any ASWebAuthenticationPresentationContextProviding
//        session.prefersEphemeralWebBrowserSession = true
        session.start()
    }
    
    private func getUserToken(code: String) async {
        try? await NetworkLayer().getUserToken(endpoint: .getUserToken(code: code))
    }
    
    private func getAuthUser() async -> User? {
        try? await NetworkLayer().getGithubContent(returnType: User.self, endpoint: .getAuthUser)
        
    }
    
}
