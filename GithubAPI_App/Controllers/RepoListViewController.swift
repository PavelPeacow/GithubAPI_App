//
//  ViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 15.11.2022.
//

import UIKit

enum GetRepos {
    case user
    case profle
}

final class RepoListViewController: UIViewController {
    
    private var repos = [Repo]()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .purple
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Repositories"
        
        view.addSubview(tableView)
        view.backgroundColor = .red
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
    
    func configureRepos(with type: GetRepos, _ username: String?) {
        Task {
            switch type {
            case .user:
                await getUserRepos(usernmame: username ?? "")
            case .profle:
                await getProfileRepos()
            }
        }
    }
    
}

extension RepoListViewController {
    private func getProfileRepos() async {
        do {
            let repos = try await APIManager.shared.getProfileRepo()
            DispatchQueue.main.async { [weak self] in
                self?.repos = repos
                self?.tableView.reloadData()
            }
            print(repos)
        } catch {
            print(error)
        }
    }
    
    private func getUserRepos(usernmame: String) async {
        do {
            let repos = try await APIManager.shared.getUserRepo(with: usernmame)
            DispatchQueue.main.async { [weak self] in
                self?.repos = repos
                self?.tableView.reloadData()
            }
            print(repos)
        } catch {
            print(error)
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
    
}


