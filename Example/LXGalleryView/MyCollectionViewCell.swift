//
//  MyCollectionViewCell.swift
//  LXGalleryView_Example
//
//  Created by Leon Hoppe on 18.06.18.
//  Copyright © 2018 Leon Hoppe. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    public let imageView: UIImageView = UIImageView()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Functions
    func setup() {
        self.imageView.frame = self.bounds
        self.addSubview(self.imageView)
        self.imageView.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
}
