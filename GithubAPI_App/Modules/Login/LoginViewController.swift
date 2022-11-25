//
//  LoginViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 17.11.2022.
//

import UIKit
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    private let loginViewModel = LoginViewModel()
    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard APIManager.shared.accessToken != nil else { return }
        loginView.loginButton.loadIndicator(shouldShow: true)
        Task {
            if let user = try? await APIManager.shared.getGithubContentWithAuthToken(returnType: User.self, endpoint: .getAuthUser) {
                let vc = UserProfileViewController()
                vc.configure(with: user, isAuthUser: true)
                navigationController?.setViewControllers([vc], animated: true)
                loginView.loginButton.loadIndicator(shouldShow: false)
            }
        }
    }
    
    override func loadView() {
        view = loginView
    }
    
    private func setTargets() {
        loginView.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
}

extension LoginViewController {
    @objc private func didTapLoginButton() {
        loginView.loginButton.loadIndicator(shouldShow: true)
        
        loginViewModel.loadGitHubAuthPromt(in: self, onCompleteion: { [weak self] user in
            
            if let user = user {
                DispatchQueue.main.async {
                    let vc = UserProfileViewController()
                    vc.configure(with: user, isAuthUser: true)
                    self?.navigationController?.setViewControllers([vc], animated: true)
                    
                }
            }
            DispatchQueue.main.async {
                self?.loginView.loginButton.loadIndicator(shouldShow: false)
            }
        })
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}

