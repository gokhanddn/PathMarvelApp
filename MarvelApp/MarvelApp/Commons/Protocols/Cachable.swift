//
//  Cachable.swift
//  MarvelApp
//
//  Created by GOKHAN on 21.04.2022.
//

import UIKit

protocol Cachable {}

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView: Cachable {}

extension Cachable where Self: UIImageView {
    
    typealias SuccessCompletion = (Bool) -> ()
    func image(from URLString: String, placeHolder: UIImage?) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        self.image = placeHolder
        
        app.service.downloadImage(from: URLString) { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let data = data,
                   let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                    self.image = downloadedImage
                    return
                }
                self.image = placeHolder
            }
        }
    }
}
