//
//  LoginVIew.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import UIKit

final class LoginView: UIView {
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [githubIcon, appTitle, loginButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 25
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    lazy var appTitle: UILabel = {
        let label = UILabel()
        label.text = "RepoViewer"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    lazy var githubIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        image.image = UIImage(systemName: "person.circle")
        return image
    }()
    
    lazy var loginButton: UIButtonWithActivityIndicator = {
        let button = UIButtonWithActivityIndicator()
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(stackView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.heightAnchor.constraint(equalToConstant: 400),
            stackView.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}
