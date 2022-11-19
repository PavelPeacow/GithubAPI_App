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
    
    func downloadImage(with url: String) {
        let url = URL(string: url)
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            print("image was cached")
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                
                imageCache.setObject(image as AnyObject, forKey: url as AnyObject)
                
                DispatchQueue.main.async {
                    self.image = image
                }
            } catch {
                print(error)
            }
            
        }
    }
    
}
