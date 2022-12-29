//
//  UITableViewCell+LoadingIndicator.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 29.12.2022.
//

import Foundation

import UIKit

extension UITableViewCell {

    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium

        self.contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
        ])
        activityIndicator.startAnimating()

        self.isUserInteractionEnabled = false
    }

    func hideLoadingIndicator() {
        self.isUserInteractionEnabled = true
        
        for subview in self.contentView.subviews {
            if let activityIndicator = subview as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
