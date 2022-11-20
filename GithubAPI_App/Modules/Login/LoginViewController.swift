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
            
            DispatchQueue.main.async { [weak self] in
                let vc = UserProfileViewController()
                vc.configure(with: user, isAuthUser: true)
                self?.navigationController?.setViewControllers([vc], animated: true)
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

