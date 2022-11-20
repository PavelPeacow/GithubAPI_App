//
//  UserProfileViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 19.11.2022.
//

import UIKit

final class UserProfileViewController: UIViewController {
    
    var isAuthUser = false
    
    let userProfileView = UserProfileView()
    let userProfileViewModel = UserProfileViewModel()
    
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
        userProfileViewModel.user = model
        
        self.isAuthUser = isAuthUser
        
        userProfileView.userName.text = model.login
        userProfileView.userBio.text = model.bio
        userProfileView.userRealName.text = model.name
        userProfileView.userAvatar.downloadImage(with: model.avatar_url)
        
        userProfileView.followingLabel.text = "following: \(model.following ?? 0)"
        userProfileView.followersLabel.text = "followers: \(model.followers ?? 0)"
    }
    
}

extension UserProfileViewController {
    
    @objc func didTapReposButton() {
        userProfileViewModel.loadRepos(isAuthUser: isAuthUser) { [weak self] repos in
            DispatchQueue.main.async {
                if !repos.isEmpty {
                    let vc = RepoListViewController()
                    vc.configureRepos(with: repos)
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self?.doNotHaveReposAlert()
                }
            }
        }
    }
}
