//
//  UserProfileViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 19.11.2022.
//

import UIKit

final class UserProfileViewController: UIViewController {
    
    private lazy var userAvatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "PavelPeacow"
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userRealName: UILabel = {
        let label = UILabel()
        label.text = "Pavel Kai"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userBio: UILabel = {
        let label = UILabel()
        label.text = "20 y.o student, interested in iOS development.\r\nLearning Swift.\r\nTelegram: @Pavel_Kai"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.text = "followers 4"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = "following: 7"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    private lazy var stackViewMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackView, stackView1])
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.backgroundColor = .green
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackView1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackView, userRealName, userName, userBio])
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.backgroundColor = .blue
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userAvatar])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.backgroundColor = .red
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(stackViewMain)
        view.backgroundColor = .systemBackground
        
        setConstraints()
    }
    
//    private func addSubviews() {
//        [stackViewMain]
//                   .forEach { view.addSubview($0) }
//    }
    
    func configure(with model: User) {
        userName.text = model.login
        userBio.text = model.bio
        userAvatar.downloadImage(with: model.avatar_url)
    }
    
}

extension UserProfileViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewMain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            stackViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            userAvatar.heightAnchor.constraint(equalToConstant: 80),
            userAvatar.widthAnchor.constraint(equalToConstant: 80),
        ])
    }
}
