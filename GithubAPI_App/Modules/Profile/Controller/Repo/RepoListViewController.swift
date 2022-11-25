//
//  ViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 15.11.2022.
//

import UIKit

final class RepoListViewController: UIViewController {
    
    private var repos = [Repo]()
    private var username = ""
    
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
        self.username = username
        title = "\(username) Repositories"
    }
    
}

extension RepoListViewController {
    func getRepoContent(username: String, repoName: String, path: String?) async -> [RepoContent]? {
        do {
            let content = try await APIManager.shared.getGithubContentWithAuthToken(returnType: [RepoContent].self, endpoint: .getRepoContent(owner: username, repositoryName: repoName, path: path))
            print(content)
            return content
        } catch {
            print(error)
            return nil
        }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let username = username
        let repoName = repos[indexPath.row].name ?? ""
        
        Task {
            if let content = await getRepoContent(username: username, repoName: repoName, path: nil) {
                let vc = RepoContentListViewController()
                vc.configureRepos(with: content, username: username, repoName: repos[indexPath.row].name ?? "")
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
}


