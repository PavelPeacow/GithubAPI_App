//
//  UserProfileView+Alert.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import UIKit

extension UserProfileViewController {
    
    func doNotHaveReposAlert() {
        let ac = UIAlertController(title: "User does not have any repos!", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel)
        
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    func doNotHavePeopleAlert(type: PeopleType) {
        let title: String
        
        switch type {
        case .followers:
            title = "User does not have any followers!"
        case .following:
            title = "User does not follow anyone!"
        }
        
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel)
        
        ac.addAction(cancel)
        present(ac, animated: true)
    }
}
