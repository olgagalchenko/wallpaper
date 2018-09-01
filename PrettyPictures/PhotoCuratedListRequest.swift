//
//  PhotoCuratedListRequest.swift
//  PrettyPictures
//
//  Created by Olga Galchenko on 9/1/18.
//  Copyright © 2018 Olga Galchenko. All rights reserved.
//

import Foundation

class PhotoCuratedListRequest: APIRequest {
    init() {
        super.init(path: "/photos/curated")
    }
}
