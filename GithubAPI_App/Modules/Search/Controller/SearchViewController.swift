//
//  SearchViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 19.11.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private let searchViewModel = SearchViewModel()
    
    private let seacrhController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RepoViewer"
        view.backgroundColor = .systemBackground
        navigationItem.searchController = seacrhController
        setDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchView.searchTable.frame = view.bounds
    }
    
    override func loadView() {
        view = searchView
    }
    
    private func setDelegates() {
        searchView.searchTable.delegate = self
        searchView.searchTable.dataSource = self
        seacrhController.searchResultsUpdater = self
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: searchViewModel.users[indexPath.row])
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        Task {
            let username = searchViewModel.users[indexPath.row].login
            if let user = await searchViewModel.getUser(username: username) {
                let vc = UserProfileViewController()
                vc.configure(with: user, isAuthUser: false)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        searchViewModel.debounceTimer?.invalidate()
        
        if !searchViewModel.users.isEmpty {
            searchView.searchTable.backgroundView = nil
        }
        
        guard let query = searchBar.text, searchBar.text?.count ?? 0 > 1 else {
            searchViewModel.users = []
            searchView.searchTable.setEmptyMessageInTableView("Start typing to find user", .headline)
            searchView.searchTable.reloadData()
            return
        }
        
        searchViewModel.debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            Task {
                let users = await self?.searchViewModel.searchForUser(username: query, page: "1")
                self?.searchViewModel.users = users?.items ?? []
                self?.searchView.searchTable.reloadData()
            }
        }
        
       
        
    }
}

