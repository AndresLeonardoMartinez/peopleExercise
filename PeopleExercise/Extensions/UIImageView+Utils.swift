//
//  UIImageView+Utils.swift
//  CCLEvents
//
//  Created by Andres Leonardo Martinez on 08/10/2019.
//  Copyright © 2019 Carnival Corporation. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

public class CustomImageView: UIImageView {

    var imageUrlString: String?

    public func loadImageUsingCache(urlString: String, completion: @escaping (Bool) -> Void) {
        imageUrlString = urlString

        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
                self.image = cachedImage
                completion(true)
                return
        }

        self.image = nil

        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                if let cachedImage = imageCache.object(forKey: urlString as NSString) {
                    DispatchQueue.main.async {
                        self.image = cachedImage
                        completion(true)
                        return
                    }

                }
				print(error ?? "No error")
                completion(false)
                return
            }

            guard let data = data else {
                completion(false)
                return
            }
            DispatchQueue.main.async {

                let imageToCache = UIImage(data: data)

                if self.imageUrlString == urlString {
                    self.image = imageToCache
                    completion(true)
                }

                imageCache.setObject(imageToCache!, forKey: urlString as NSString)

                return

            }
        }.resume()
    }
}
