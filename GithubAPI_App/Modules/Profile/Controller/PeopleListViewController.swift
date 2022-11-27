//
//  FollowersListViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 21.11.2022.
//

import UIKit

enum PeopleType {
    case followers
    case following
}

final class PeopleListViewController: UIViewController {
    
    private let peopleListViewModel = PeopleListViewModel()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .purple
        table.rowHeight = 80
        table.layer.cornerRadius = 10
        table.separatorColor = .white
        table.separatorInset = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        table.register(PeopleTableViewCell.self, forCellReuseIdentifier: PeopleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        setDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configure(with users: [User], username: String, type: PeopleType) {
        peopleListViewModel.users = users
        switch type {
        case .followers:
            title = "\(username) followers"
        case .following:
            title = "\(username) following"
        }
    }
    
}

extension PeopleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        peopleListViewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PeopleTableViewCell.identifier, for: indexPath) as? PeopleTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: peopleListViewModel.users[indexPath.row])
        return cell
    }
    
}

extension PeopleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        Task {
            let username = peopleListViewModel.users[indexPath.row].login
            if let user = await peopleListViewModel.getUser(username: username) {
                let vc = UserProfileViewController()
                vc.configure(with: user, isAuthUser: false)
                navigationController?.pushViewController(vc, animated: true)
            } else {
                print("user not found")
            }
        }
        
    }
}
