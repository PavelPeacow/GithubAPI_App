//
//  SearchView.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import UIKit

final class SearchView: UIView {

     lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [seacrhLabel, searchTextfield, searchButton])
        stackView.spacing = 25
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
     lazy var seacrhLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter user name you want to find!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var searchTextfield: UITextField = {
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
    
     lazy var searchButton: UIButtonWithActivityIndicator = {
        let button = UIButtonWithActivityIndicator()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(stackView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            searchTextfield.heightAnchor.constraint(equalToConstant: 30),
            searchTextfield.widthAnchor.constraint(equalToConstant: 300),
            
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}
