//
//  SearchViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 19.11.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [seacrhLabel, searchTextfield, searchButton])
        stackView.spacing = 25
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var seacrhLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter user name you want to find!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchTextfield: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.layer.cornerRadius = 5
        field.textColor = .black
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        field.leftView?.backgroundColor = .red
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RepoViewer"
        
        view.addSubview(stackView)

        view.backgroundColor = .systemBackground
        setConstraints()
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
            let result = try await APIManager.shared.getUser(username: searchTextfield.text ?? "")
            
            let vc = UserProfileViewController()
            vc.configure(with: result, isAuthUser: false)
            navigationController?.pushViewController(vc, animated: true)
        } catch {
            print(error)
        }
       
    }
}

extension SearchViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            searchTextfield.heightAnchor.constraint(equalToConstant: 30),
            searchTextfield.widthAnchor.constraint(equalToConstant: 300),
            
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}
