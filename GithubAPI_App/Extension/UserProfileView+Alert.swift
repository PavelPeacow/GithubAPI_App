//
//  UserProfileView+Alert.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import UIKit

extension UserProfileViewController {
    
    func doNotHaveReposAlert() {
        let ac = UIAlertController(title: "User do not have any repos!", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel)
        
        ac.addAction(cancel)
        present(ac, animated: true)
    }
}
