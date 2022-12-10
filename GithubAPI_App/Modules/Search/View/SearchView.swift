//
//  SearchView.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 20.11.2022.
//

import UIKit

final class SearchView: UIView {
    
    lazy var searchTable: UITableView = {
        let searchTable = UITableView(frame: .zero, style: .plain)
        searchTable.backgroundColor = .systemBackground
        searchTable.rowHeight = 120
        searchTable.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return searchTable
    }()
        
    init() {
        super.init(frame: .zero)
        addSubview(searchTable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

