//
//  RepoList+Alert.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 27.11.2022.
//

import UIKit

extension RepoListViewController {
    
    func emptyRepoAlert() {
        let ac = UIAlertController(title: "Repo is empty!", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel)
        
        ac.addAction(cancel)
        present(ac, animated: true)
    }
}
