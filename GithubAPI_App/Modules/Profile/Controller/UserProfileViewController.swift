//
//  UserProfileViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 19.11.2022.
//

import UIKit

final class UserProfileViewController: UIViewController {
    
    private var isAuthUser = false
    
    private let userProfileView = UserProfileView()
    private let userProfileViewModel = UserProfileViewModel()
    
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
        
        let tapFollowersGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFollowersLabel))
        let tapFollowingGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFollowingLabel))
        
        userProfileView.followingLabel.addGestureRecognizer(tapFollowingGesture)
        userProfileView.followersLabel.addGestureRecognizer(tapFollowersGesture)
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
    
    @objc func didTapFollowersLabel() {
        Task {
            let users = await userProfileViewModel.getUserFollowers()
            let vc = PeopleListViewController()
            vc.configure(with: users ?? [], username: userProfileViewModel.user.login, type: .followers)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func didTapFollowingLabel() {
        Task {
            let users = await userProfileViewModel.getUserFollowing()
            let vc = PeopleListViewController()
            vc.configure(with: users ?? [], username: userProfileViewModel.user.login, type: .following)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func didTapReposButton() {
        userProfileView.showReposButton.loadIndicator(shouldShow: true)
        userProfileViewModel.loadRepos(isAuthUser: isAuthUser) { [weak self] repos in
            DispatchQueue.main.async {
                if !repos.isEmpty {
                    let vc = RepoListViewController()
                    vc.configureRepos(with: repos, username: self?.userProfileViewModel.user.login ?? "")
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self?.doNotHaveReposAlert()
                }
                self?.userProfileView.showReposButton.loadIndicator(shouldShow: false)
            }
        }
    }
}
