//
//  ViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 15.11.2022.
//

import UIKit

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
        Task {
            await getRepos()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension RepoListViewController {
    private func getRepos() async {
        do {
            let repos = try await APIManager.shared.getRepo(with: APIManager.shared.accessToken ?? "")
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
        cell.textLabel?.text = repos[indexPath.row].name ?? "loh"
        cell.imageView?.image = UIImage(systemName: "folder.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return cell
    }
    
    
}

extension RepoListViewController: UITableViewDelegate {
    
}


