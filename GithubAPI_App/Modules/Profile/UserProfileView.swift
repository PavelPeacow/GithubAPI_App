//
//  UserProfileView.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import UIKit

class UserProfileView: UIView {
    
    lazy var userAvatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.clipsToBounds = true
        image.layer.cornerRadius = 28
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "PavelPeacow"
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userRealName: UILabel = {
        let label = UILabel()
        label.text = "Pavel Kai"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userBio: UILabel = {
        let label = UILabel()
        label.text = "20 y.o student, interested in iOS development.\r\nLearning Swift.\r\nTelegram: @Pavel_Kai"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var showReposButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show repositories", for: .normal)
        return button
    }()
    
    lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.text = "followers: 4"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = "following: 7"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var stackViewMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackView, stackView1])
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 25
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackView1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackView, userRealName, userName, userBio])
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userAvatar])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 15, bottom: 3, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 25
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [stackViewMain, horizontalStackView, showReposButton]
                   .forEach { addSubview($0) }
    }
    
}

extension UserProfileView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewMain.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 130),
            stackViewMain.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            stackViewMain.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            userAvatar.heightAnchor.constraint(equalToConstant: 80),
            userAvatar.widthAnchor.constraint(equalToConstant: 80),
            
            horizontalStackView.topAnchor.constraint(equalTo: stackViewMain.bottomAnchor, constant: 15),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            showReposButton.heightAnchor.constraint(equalToConstant: 40),
            showReposButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            showReposButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            showReposButton.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 15),
        ])
    }
}
