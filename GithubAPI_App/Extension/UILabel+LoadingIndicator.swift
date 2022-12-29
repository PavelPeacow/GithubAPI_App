//
//  UILabel+LoadingIndicator.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 29.12.2022.
//

import Foundation

import UIKit

extension UILabel {

    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium

        activityIndicator.center = self.center
        self.superview?.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        self.alpha = 0.0
        self.isUserInteractionEnabled = false
    }

    func hideLoadingIndicator() {
        self.isUserInteractionEnabled = true
        self.alpha = 1.0
        
        for subview in self.superview?.subviews ?? [] {
            if let activityIndicator = subview as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
