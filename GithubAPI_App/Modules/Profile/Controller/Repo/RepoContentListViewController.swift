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
            let content = try await APIManager.shared.getGithubContentWithAuthToken(returnType: [RepoContent].self, endpoint: .getRepoContent(owner: username, repositoryName: repoName, path: path))
            return content
        } catch {
            print(error)
            return nil
        }
    }
    
    func getRepoContentSingle(username: String, repoName: String, path: String) async -> RepoContent? {
        do {
            let content = try await APIManager.shared.getGithubContentWithAuthToken(returnType: RepoContent.self, endpoint: .getRepoContent(owner: username, repositoryName: repoName, path: path))
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
        let repoItem = repoContent[indexPath.row]
        let repoIcon: UIImage?
        cell.textLabel?.text = repoItem.name
        
        if repoItem.type == "file" { repoIcon = UIImage(systemName: "doc.fill") } else { repoIcon = UIImage(systemName: "folder.fill") }
        
        cell.imageView?.image = repoIcon?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return cell
    }
    
}

extension RepoContentListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let repoItem = repoContent[indexPath.row]
        
        let username = username
        let repoName = repoName
        let path = repoItem.path ?? ""
        
        if repoItem.type != "file" {
            
            Task {
                if let content = await getRepoContent(username: username, repoName: repoName, path: path) {
                    let vc = RepoContentListViewController()
                    vc.configureRepos(with: content, username: username, repoName: repoName)
                    navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            
        } else {
            
            Task {
                if let content = await getRepoContentSingle(username: username, repoName: repoName, path: path) {
                    let vc = FileContentViewController()
                    vc.configure(with: content)
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
           
        }
        
        
    }
}
