//
//  PhotoViewController.swift
//  PrettyPictures
//
//  Created by Olga Galchenko on 8/30/18.
//  Copyright © 2018 Olga Galchenko. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    let imageView = UIImageView()
    let photoUrl: URL
    
    init(url: URL) {
        self.photoUrl = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.contentMode = .scaleAspectFit
        self.imageView.frame = self.view.frame
        self.view.addSubview(self.imageView)
        
        URLSession.shared.dataTask(with: self.photoUrl, completionHandler: { (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}
