//
//  ViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 15.11.2022.
//

import UIKit

final class RepoListViewController: UIViewController {
    
    private var repos = [Repo]()
    private let userProfileVIewModel = UserProfileViewModel()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    
    func configureRepos(with repos: [Repo], username: String) {
        self.repos = repos
        title = "\(username) Repositories"
    }
    
}

extension RepoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = repos[indexPath.row].name ?? ""
        cell.imageView?.image = UIImage(systemName: "folder.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return cell
    }
    
}

extension RepoListViewController: UITableViewDelegate {
    
}


