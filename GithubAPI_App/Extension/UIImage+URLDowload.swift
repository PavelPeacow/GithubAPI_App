//
//  UIImage+URLDowload.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 19.11.2022.
//

import Foundation
import UIKit

fileprivate let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func downloadImage(with urlImage: String) {
        guard let url = URL(string: urlImage) else { return }
        
        if let cachedImage = imageCache.object(forKey: urlImage as NSString) as? UIImage {
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: urlImage as NSString)
                    print("image was cached")
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            } catch {
                print(error)
            }
            
        }
    }
    
}
