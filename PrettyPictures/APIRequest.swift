//
//  APIRequest.swift
//  PrettyPictures
//
//  Created by Olga Galchenko on 9/1/18.
//  Copyright © 2018 Olga Galchenko. All rights reserved.
//

import Foundation

class APIRequest {
    static let baseURL: String = "https://api.unsplash.com/"
    static let clientId: String = "44291bad7b832bd9c8710bf904f2d8d0cfaa20a89779023c580c0658b839a3b2"
    
    let url: URL
    
    init(path: String) {
        var unsplashUrlComponents = URLComponents(string: APIRequest.baseURL)!
        let clientId = URLQueryItem(name: "client_id", value: APIRequest.clientId)
        unsplashUrlComponents.queryItems = [clientId]
        unsplashUrlComponents.path = path
        self.url = unsplashUrlComponents.url!
    }
}
