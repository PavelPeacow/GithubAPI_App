//
//  SearchViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 19.11.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    let searchView = SearchView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RepoViewer"
        view.backgroundColor = .systemBackground
        setTargets()
    }
    
    override func loadView() {
        view = searchView
    }

    private func setTargets() {
        searchView.searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
    }

}

extension SearchViewController {
    @objc func didTapSearchButton() {
        Task {
            await getUser()
        }
    }
    
    private func getUser() async {
        do {
            let result = try await APIManager.shared.getUser(username: searchView.searchTextfield.text ?? "")
            
            let vc = UserProfileViewController()
            vc.configure(with: result, isAuthUser: false)
            navigationController?.pushViewController(vc, animated: true)
        } catch {
            print(error)
        }
       
    }
}


