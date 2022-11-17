//
//  LoginViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 17.11.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
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
        
        view.addSubview(stackView)
        
        view.backgroundColor = .systemBackground
        setConstraints()
    }
    

}

extension LoginViewController {
    @objc private func didTapLoginButton() {
        let view = WebViewRequestLoginViewController()
        present(view, animated: true)
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
