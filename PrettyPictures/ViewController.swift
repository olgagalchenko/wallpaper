//
//  ViewController.swift
//  PrettyPictures
//
//  Created by Olga Galchenko on 8/29/18.
//  Copyright © 2018 Olga Galchenko. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController {

    var orderedViewControllers: [PhotoViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCuratedPhotos()
        self.dataSource = self
    }

    func getCuratedPhotos() {
        Photo.curatedPhotos { (photos) in
            
            DispatchQueue.main.async {
                let photoViewControllers: [PhotoViewController] = photos.map({ (photo) -> PhotoViewController in
                    PhotoViewController(url: photo.url)
                })
            
                guard let firstPhotoVC = photoViewControllers.first else {
                    return
                }
                self.setViewControllers([firstPhotoVC], direction: .forward, animated: false, completion: nil)
                self.orderedViewControllers = photoViewControllers
            }
        }
    }
}

extension ViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.orderedViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! PhotoViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! PhotoViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
}
