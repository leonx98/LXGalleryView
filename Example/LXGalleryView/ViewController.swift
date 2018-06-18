//
//  ViewController.swift
//  LXGalleryView
//
//  Created by Leon Hoppe on 06.14.2018.
//  Copyright (c) 2018 Leon Hoppe. All rights reserved.
//

import UIKit
import LXGalleryView

class ViewController: UIViewController {
    
    //MARK: Properties
    var galleryView: LXGalleryView!
    let images = [UIImage(named: "Example_1"),
                  UIImage(named: "Example_2"),
                  UIImage(named: "Example_3"),
                  UIImage(named: "Example_4"),
                  UIImage(named: "Example_5")]

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250)
        self.galleryView = LXGalleryView(frame: frame, delegate: self, dataSource: self)
        self.galleryView.center = self.view.center
        self.galleryView.galleryCollection.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        self.galleryView.areButtonsHidden = false
        
        self.view.addSubview(self.galleryView)
    }

}

extension ViewController: LXGalleryViewDataSource, LXGalleryViewDelegate {
    func galleryView(_ galleryView: LXGalleryView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func galleryView(_ galleryView: LXGalleryView, cellForItemAt: IndexPath) -> UICollectionViewCell {
        let cell = galleryView.galleryCollection.dequeueReusableCell(withReuseIdentifier: "MyCell", for: cellForItemAt) as! MyCollectionViewCell
        cell.imageView.image = images[cellForItemAt.row]
        
        return cell
    }
}

