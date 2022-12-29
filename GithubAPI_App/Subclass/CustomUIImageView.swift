//
//  CutomUIImageView.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 10.12.2022.
//

import UIKit

fileprivate let imageCache = NSCache<AnyObject, AnyObject>()

final class CustomUIImageView: UIImageView {

    var task: URLSessionDataTask!
    let loadingView = UIActivityIndicatorView(style: .large)
    
    func loadImage(for url: URL) {
        image = nil
        
        setLoadingView()
        
        if let task = task {
            task.cancel()
        }
        
        if let imageCache = imageCache.object(forKey: url.absoluteURL as AnyObject) as? UIImage {
            self.image = imageCache
            removeLoadingView()
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { data, resp, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            imageCache.setObject(image, forKey: url.absoluteURL as AnyObject)
            
            DispatchQueue.main.async {
                self.image = image
                self.removeLoadingView()
            }
            
        }
        task.resume()
                
    }
    
    private func setLoadingView() {
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        loadingView.startAnimating()
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func removeLoadingView() {
        loadingView.removeFromSuperview()
    }

}

