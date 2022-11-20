//
//  UserProfileViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 19.11.2022.
//

import UIKit

final class UserProfileViewController: UIViewController {
    
    var user: User!
    var isAuthUser = false
    
    private lazy var userAvatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.clipsToBounds = true
        image.layer.cornerRadius = 28
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "PavelPeacow"
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userRealName: UILabel = {
        let label = UILabel()
        label.text = "Pavel Kai"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userBio: UILabel = {
        let label = UILabel()
        label.text = "20 y.o student, interested in iOS development.\r\nLearning Swift.\r\nTelegram: @Pavel_Kai"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var showReposButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(didTapReposButton), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show repositories", for: .normal)
        return button
    }()

    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.text = "followers: 4"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = "following: 7"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    private lazy var stackViewMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackView, stackView1])
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 25
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackView1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackView, userRealName, userName, userBio])
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userAvatar])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 15, bottom: 3, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 25
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        addSubviews()
        view.backgroundColor = .systemBackground
        
        setConstraints()
    }
    
    private func addSubviews() {
        [stackViewMain, horizontalStackView, showReposButton]
                   .forEach { view.addSubview($0) }
    }
    
    func configure(with model: User, isAuthUser: Bool) {
        user = model
        
        self.isAuthUser = isAuthUser
        
        userName.text = model.login
        userBio.text = model.bio
        userRealName.text = model.name
        userAvatar.downloadImage(with: model.avatar_url)
        
        followersLabel.text = "followers: \(model.followers)"
        followingLabel.text = "following: \(model.following)"
    }
    
}

extension UserProfileViewController {
    
    @objc func didTapReposButton() {
        let vc = RepoListViewController()
        vc.configureRepos(with: isAuthUser ? .profle : .user, isAuthUser ? nil : user.login)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension UserProfileViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewMain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            stackViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            userAvatar.heightAnchor.constraint(equalToConstant: 80),
            userAvatar.widthAnchor.constraint(equalToConstant: 80),
            
            horizontalStackView.topAnchor.constraint(equalTo: stackViewMain.bottomAnchor, constant: 15),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            showReposButton.heightAnchor.constraint(equalToConstant: 40),
            showReposButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            showReposButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showReposButton.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 15),
        ])
    }
}
