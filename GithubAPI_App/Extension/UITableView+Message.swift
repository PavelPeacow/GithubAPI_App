//
//  UITableView+Message.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 29.12.2022.
//

import UIKit

extension UITableView {
    
    func setEmptyMessageInTableView(_ message: String, _ preferredFont: UIFont.TextStyle) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .systemGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.preferredFont(forTextStyle: preferredFont)
       
        self.backgroundView = messageLabel;
    }
    
}
