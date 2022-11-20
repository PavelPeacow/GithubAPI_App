//
//  UIButtonSearch.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import UIKit

final class UIButtonWithActivityIndicator: UIButton {
    
    var activityIndicator: UIActivityIndicatorView!
    
    func loadIndicator(shouldShow: Bool) {
        if shouldShow {
            if (activityIndicator == nil) {
                activityIndicator = createActivityIndicator()
            }
            isEnabled = false
            alpha = 0.7
            showSpinning()
        } else {
            activityIndicator.stopAnimating()
            isEnabled = true
            alpha = 1.0
        }
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        return activityIndicator
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
