//
//  UIButtonSearch.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import UIKit

final class UIButtonWithActivityIndicator: UIButton {
    
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    func loadIndicator(shouldShow: Bool) {
        if shouldShow {
            isEnabled = false
            alpha = 0.7
            showSpinning()
        } else {
            isEnabled = true
            alpha = 1.0
            activityIndicator.stopAnimating()
        }
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
}
