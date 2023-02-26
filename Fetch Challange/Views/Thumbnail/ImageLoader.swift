//
//  ImageCache.swift
//  Fetch Challange
//
//  Created by Teryl S on 2/23/23.
//

import UIKit
import Foundation
import OSLog

class ImageLoader: ObservableObject {

    public static let publicCache = ImageLoader()
    private let cachedImages = NSCache<NSURL, UIImage>()
    
    // MARK: Logging

    let logger = Logger(subsystem: "com.example.Fetch-Challenge.Desserts", category: "ImageLoader")
    
    public final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    // Returns the cached image if available, otherwise asynchronously loads and caches it.
    func loadAsync(url: NSURL) async -> UIImage? {
        // Check for a cached image
        if let cachedImage = image(url: url) {
            //logger.debug("Image found in cache")
            return cachedImage
        }
        
        do {
            // Go fetch the image
            let (data, _) = try await URLSession.shared.data(from: url as URL)
            
            if let imageToCache = UIImage(data: data) {
                // Cache the image
                self.cachedImages.setObject(imageToCache, forKey: url)
                return imageToCache
            }
            
        } catch {
            logger.debug("Unable to download thumbnail data for \(url.description)")
        }
        
        return nil
    }
}
