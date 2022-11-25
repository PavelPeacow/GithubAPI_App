//
//  UserProfileView.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import UIKit

final class UserProfileView: UIView {
    
    lazy var userAvatar: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userRealName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userBio: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var showReposButton: UIButtonWithActivityIndicator = {
        let button = UIButtonWithActivityIndicator()
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show repositories", for: .normal)
        return button
    }()
    
    lazy var logoutButton: UIButtonWithActivityIndicator = {
        let button = UIButtonWithActivityIndicator()
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: .normal)
        return button
    }()
    
    lazy var showInGithubButton: UIButtonWithActivityIndicator = {
        let button = UIButtonWithActivityIndicator()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show in Github", for: .normal)
        return button
    }()
    
    lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackViewBio: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userRealName, userName, userBio])
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray6
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        stackView.layer.cornerRadius = 25
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 15, bottom: 3, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 25
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [showReposButton, showInGithubButton, logoutButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [userAvatar, stackViewBio, horizontalStackView, buttonsStackView]
                   .forEach { addSubview($0) }
    }
    
}

extension UserProfileView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            userAvatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            userAvatar.centerXAnchor.constraint(equalTo: centerXAnchor),
            userAvatar.heightAnchor.constraint(equalToConstant: 110),
            userAvatar.widthAnchor.constraint(equalToConstant: 100),
            
            stackViewBio.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 15),
            stackViewBio.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackViewBio.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
                        
            horizontalStackView.topAnchor.constraint(equalTo: stackViewBio.bottomAnchor, constant: 15),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            horizontalStackView.heightAnchor.constraint(equalToConstant: 40),
            
            buttonsStackView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 25),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
        ])
    }
}
