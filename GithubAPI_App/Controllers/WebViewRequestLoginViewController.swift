//
//  WebViewRequestLoginViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 17.11.2022.
//

import UIKit
import WebKit

class WebViewRequestLoginViewController: UIViewController {

    private lazy var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadGitHubAuthPromt()
    }
    
    override func loadView() {
        view = webView
    }
    
    func loadGitHubAuthPromt() {
        guard let url = URL(string: "https://github.com/login/oauth/authorize?client_id=7968bef2c624696f25e8") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

}
