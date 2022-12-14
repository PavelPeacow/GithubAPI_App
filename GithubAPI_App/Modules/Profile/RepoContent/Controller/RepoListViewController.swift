//
//  ViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 15.11.2022.
//

import UIKit

final class RepoListViewController: UIViewController {
    
    private let repoListViewModel = RepoListViewModel()
    
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
        repoListViewModel.repos = repos
        repoListViewModel.username = username
        title = "\(username) Repositories"
    }
    
}

extension RepoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repoListViewModel.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = repoListViewModel.repos[indexPath.row].name ?? ""
        cell.imageView?.image = UIImage(systemName: "folder.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return cell
    }
    
}

extension RepoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let username = repoListViewModel.username
        let repoName = repoListViewModel.repos[indexPath.row].name ?? ""
        
        Task {
            tableView.cellForRow(at: indexPath)?.showLoadingIndicator()
            if let content = await repoListViewModel.getRepoContent(username: username, repoName: repoName, path: nil) {
                let vc = RepoContentListViewController()
                vc.configureRepos(with: content, username: username, repoName: repoListViewModel.repos[indexPath.row].name ?? "")
                navigationController?.pushViewController(vc, animated: true)
            } else {
                emptyRepoAlert()
            }
            tableView.cellForRow(at: indexPath)?.hideLoadingIndicator()
        }
        
    }
}


