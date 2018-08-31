//
//  Photo.swift
//  PrettyPictures
//
//  Created by Olga Galchenko on 8/29/18.
//  Copyright © 2018 Olga Galchenko. All rights reserved.
//

import Foundation

struct Photo {
    let id: String
    let description: String
    let url: URL
    let dimensions: (height: Int, width: Int)
}

extension Photo {
    init?(json: [String: Any]) {
        guard let id = json["id"] as? String,
            let description = json["description"] as? String,
            let urlsJSON = json["urls"] as? [String: Any],
            let urlString = urlsJSON["regular"] as? String,
            let url = URL(string: urlString),
            let height = json["height"] as? Int,
            let width = json["width"] as? Int
        else {
                return nil
        }
        
        self.id = id
        self.description = description
        self.url = url
        self.dimensions = (height, width)
    }
}

extension Photo {
    
    static func curatedPhotos(completion: @escaping ([Photo]) -> Void) {
        var unsplashUrlComponents = URLComponents(string: "https://api.unsplash.com/photos/curated")!
        let clientId = URLQueryItem(name: "client_id", value: "44291bad7b832bd9c8710bf904f2d8d0cfaa20a89779023c580c0658b839a3b2")
        unsplashUrlComponents.queryItems = [clientId]
        let unsplashUrl = unsplashUrlComponents.url!
        
        URLSession.shared.dataTask(with: unsplashUrl) { (data, _, _) in
            
            var photos: [Photo] = []
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                for case let result in json! {
                    if let photo = Photo(json: result) {
                        photos.append(photo)
                    }
                }
            }
            
            completion(photos)
            
        }.resume()
    }
}
