//
//  PeopleTableViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 21.11.2022.
//

import UIKit

final class PeopleTableViewCell: UITableViewCell {
    
    static let identifier = "PeopleTableViewCell"
    
    private lazy var personAvatar: CustomUIImageView = {
        let image = CustomUIImageView()
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var personName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(personAvatar)
        contentView.addSubview(personName)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with user: User) {
        guard let url = URL(string: user.avatar_url) else { return }
        personName.text = user.login
        personAvatar.loadImage(for: url)
    }
    
}

extension PeopleTableViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            personAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            personAvatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personAvatar.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            personAvatar.widthAnchor.constraint(equalToConstant: 60),
            
            personName.leadingAnchor.constraint(equalTo: personAvatar.trailingAnchor, constant: 10),
            personName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
