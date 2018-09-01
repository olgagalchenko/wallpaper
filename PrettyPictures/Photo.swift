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
        
        let curatedPhotosRequest = PhotoCuratedListRequest()
        let photosAPI = PhotoAPI()
        
        URLSession.shared.dataTask(with: curatedPhotosRequest.url) { (data, _, _) in
            
            let photos: [Photo] = photosAPI.deserialize(data: data)
            completion(photos)
            
        }.resume()
    }
}

protocol APIDispatcher {
    associatedtype T
    func deserialize(data: Data?) -> T
}

class PhotoAPI: APIDispatcher {
    
    typealias T = [Photo]
    
    func deserialize(data: Data?) -> [Photo] {
        
        var photos: [Photo] = []

        if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
            for case let result in json! {
                if let photo = Photo(json: result) {
                    photos.append(photo)
                }
            }
        }
        
        return photos
    }
}
