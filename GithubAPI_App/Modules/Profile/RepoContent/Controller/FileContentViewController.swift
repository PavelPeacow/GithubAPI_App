//
//  FileContentViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 23.11.2022.
//

import UIKit

final class FileContentViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.addSubview(label)
        view.backgroundColor = .systemBackground
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
    }
    
    func configure(with content: RepoContent) {
        label.text = content.content?.base64Decode()
        title = content.path ?? ""
    }
    
}

extension FileContentViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 15),
            label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
        ])
    }
}
