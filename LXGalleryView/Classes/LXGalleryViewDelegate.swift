//
//  LXGalleryViewDelegate.swift
//  LXGalleryView
//
//  Created by Leon Hoppe on 14.06.18.
//

import Foundation

@objc public protocol LXGalleryViewDelegate {
    @objc optional func galleryViewDidPaged(_ galleryView: LXGalleryView, toPage: Int)
    @objc optional func galleryViewDidScroll(_ galleryView: LXGalleryView)
}

