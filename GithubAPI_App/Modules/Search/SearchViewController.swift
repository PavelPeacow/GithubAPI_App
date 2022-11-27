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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RepoViewer"
        view.backgroundColor = .systemBackground
        setTargets()
        setDelegates()
    }
    
    override func loadView() {
        view = searchView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setTargets() {
        searchView.searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
    }
    
    private func setDelegates() {
        searchView.searchTextfield.delegate = self
    }

}

extension SearchViewController {
    @objc func didTapSearchButton() {
        searchView.searchButton.loadIndicator(shouldShow: true)
        Task {
            if let user = await searchViewModel.getUser(username: searchView.searchTextfield.text ?? "") {
                let vc = UserProfileViewController()
                vc.configure(with: user, isAuthUser: false)
                navigationController?.pushViewController(vc, animated: true)
            } else {
                doNotFindUserAlert()
            }
            searchView.searchButton.loadIndicator(shouldShow: false)
        }
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

