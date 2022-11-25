//
//  SearchViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 19.11.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
        
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
        Task {
            searchView.searchButton.loadIndicator(shouldShow: true)
            await getUser(username: searchView.searchTextfield.text ?? "")
            searchView.searchButton.loadIndicator(shouldShow: false)
        }
    }
    
    private func getUser(username: String) async {
        do {
            let result = try await APIManager.shared.getGithubContentProfileRelated(returnType: User.self, endpoint: .getUserProfile(username: username))
            
            let vc = UserProfileViewController()
            vc.configure(with: result, isAuthUser: false)
            navigationController?.pushViewController(vc, animated: true)
        } catch {
            doNotFindUserAlert()
            print(error)
        }
       
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

