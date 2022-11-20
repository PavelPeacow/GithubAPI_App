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
    
    let userProfileView = UserProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setTargets()
    }
    
    override func loadView() {
        view = userProfileView
    }
    
    private func setTargets() {
        userProfileView.showReposButton.addTarget(self, action: #selector(didTapReposButton), for: .touchUpInside)
    }
    
    func configure(with model: User, isAuthUser: Bool) {
        user = model
        
        self.isAuthUser = isAuthUser
        
        userProfileView.userName.text = model.login
        userProfileView.userBio.text = model.bio
        userProfileView.userRealName.text = model.name
        userProfileView.userAvatar.downloadImage(with: model.avatar_url)
        
        userProfileView.followersLabel.text = "followers: \(model.followers)"
        userProfileView.followingLabel.text = "following: \(model.following)"
    }
    
}

extension UserProfileViewController {
    
    @objc func didTapReposButton() {
        let vc = RepoListViewController()
        vc.configureRepos(with: isAuthUser ? .profle : .user, isAuthUser ? nil : user.login)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
