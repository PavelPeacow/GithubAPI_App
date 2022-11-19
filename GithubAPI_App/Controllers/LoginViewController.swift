//
//  LoginViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 17.11.2022.
//

import UIKit
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [githubIcon, appTitle, loginButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 25
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    

    private lazy var appTitle: UILabel = {
        let label = UILabel()
        label.text = "RepoViewer"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private lazy var githubIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        image.image = UIImage(systemName: "person.circle")
        return image
    }()
        
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.setTitle("Login", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = APIManager.shared.accessToken {
            navigationController?.setViewControllers([RepoListViewController()], animated: true)
        }
        
        view.addSubview(stackView)
        
        view.backgroundColor = .systemBackground
        setConstraints()
    }
    

}

extension LoginViewController {
    @objc private func didTapLoginButton() {
        loadGitHubAuthPromt()
    }
    
    func loadGitHubAuthPromt() {
        guard let url = URL(string: "https://github.com/login/oauth/authorize?client_id=7968bef2c624696f25e8&scope=read:user&state=TEST_STATE") else { return }
        let callBackScheme = "pavel.github.test.app"
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callBackScheme) { callBackURL, error in
            guard let callBackURL = callBackURL, error == nil else { print("error"); return}
            
            guard let query = URLComponents(string: callBackURL.absoluteString)?.queryItems else { return }
            guard let code = query.first(where: { $0.name == "code" } )?.value else { return }
            
            print(code)
            
            Task { [weak self] in
                do {
                    try await APIManager.shared.getUserToken(with: code)
                    self?.navigationController?.setViewControllers([RepoListViewController()], animated: true)
                } catch {
                    print(error)
                }
              
            }
        }
        session.presentationContextProvider = self
        session.start()
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}

extension LoginViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            stackView.heightAnchor.constraint(equalToConstant: 400),
            stackView.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}
