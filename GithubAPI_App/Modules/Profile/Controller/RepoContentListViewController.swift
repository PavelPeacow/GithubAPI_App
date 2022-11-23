//
//  RepoContentListViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 23.11.2022.
//

import UIKit

final class RepoContentListViewController: UIViewController {
    
    private var repoContent = [RepoContent]()
    private var username = ""
    private var repoName = ""
    
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
    
    func configureRepos(with repoContent: [RepoContent], username: String, repoName: String) {
        self.repoContent = repoContent
        self.username = username
        self.repoName = repoName
    }
    
}

extension RepoContentListViewController {
    func getRepoContent(username: String, repoName: String, path: String) async -> [RepoContent]? {
        do {
            let content = try await APIManager.shared.getRepoContent(owner: username, repositoryName: repoName, path: path)
            print(content)
            return content
        } catch {
            print(error)
            return nil
        }
    }
}

extension RepoContentListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repoContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = repoContent[indexPath.row].name
        cell.imageView?.image = UIImage(systemName: "folder.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return cell
    }
    
}

extension RepoContentListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if repoContent[indexPath.row].type != "file" {
            
            let username = username
            let repoName = repoName
            let path = repoContent[indexPath.row].path ?? ""
            
            Task {
                if let content = await getRepoContent(username: username, repoName: repoName, path: path) {
                    let vc = RepoContentListViewController()
                    vc.configureRepos(with: content, username: username, repoName: repoName)
                    navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            
        } else {
            print("file tap")
        }
        
        
    }
}
