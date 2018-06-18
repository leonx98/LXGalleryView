//
//  LXGalleryViewDataSource.swift
//  LXGalleryView
//
//  Created by Leon Hoppe on 14.06.18.
//

import UIKit

@objc public protocol LXGalleryViewDataSource {
    func galleryView(_ galleryView: LXGalleryView, numberOfItemsInSection section: Int) -> Int
    func galleryView(_ galleryView: LXGalleryView, cellForItemAt: IndexPath) -> UICollectionViewCell
}

