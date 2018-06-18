//
//  LXGalleryView.swift
//  LXGalleryView
//
//  Created by Leon Hoppe on 14.06.18.
//

import UIKit

public class LXGalleryView: UIView {
    
    //MARK: Properties
    public var galleryCollection: LXGalleryCollection!
    public weak var delegate: LXGalleryViewDelegate?
    public var dataSource: LXGalleryViewDataSource?
    public var isAnimated = true {
        didSet {
            self.galleryCollection.isAnimated = self.isAnimated
        }
    }
    public var duration: Double = 3.0 {
        didSet {
            self.galleryCollection.duration = self.duration
        }
    }
    public var isInfinite = true {
        didSet {
            self.galleryCollection.isInfinite = self.isInfinite
        }
    }
    public var rightButton: UIButton = UIButton()
    public var leftButton: UIButton = UIButton()
    public var areButtonsHidden: Bool = false {
        didSet {
            switch self.areButtonsHidden {
            case true:
                self.rightButton.isHidden = true
                self.leftButton.isHidden = true
                
            case false:
                self.rightButton.isHidden = false
                self.leftButton.isHidden = false
                
            }
        }
    }
    
    //MARK: Init
    public init(frame: CGRect, delegate: LXGalleryViewDelegate?, dataSource: LXGalleryViewDataSource) {
        super.init(frame: frame)
        self.delegate = delegate
        self.dataSource = dataSource
        self.initialConfiguration()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialConfiguration()
    }
    
    func initialConfiguration() {
        // Configure GalleryCollection
        self.galleryCollection = LXGalleryCollection(frame: self.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.addSubview(self.galleryCollection)
        self.galleryCollection.galleryView = self
        
        self.galleryCollection.translatesAutoresizingMaskIntoConstraints = false
        self.galleryCollection.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.galleryCollection.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.galleryCollection.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.galleryCollection.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        // Get bundle
        let mainBundle = Bundle(for: LXGalleryView.self)
        let bundleURL = mainBundle.resourceURL?.appendingPathComponent("LXGalleryView.bundle")
        let ressourceBundle = Bundle(url: bundleURL!)
        
        // Configure right button
        let before_img = UIImage(named: "next", in: ressourceBundle, compatibleWith: nil)
        self.rightButton.setImage(before_img, for: .normal)
        self.rightButton.setImage(before_img, for: .disabled)
        self.addSubview(self.rightButton)
        self.rightButton.addTarget(self.galleryCollection, action: #selector(self.galleryCollection.press(button:)), for: .touchUpInside)
        
        self.rightButton.translatesAutoresizingMaskIntoConstraints = false
        self.rightButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.rightButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.rightButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.rightButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        // Configure left button
        let next_img = UIImage(named: "before", in: ressourceBundle, compatibleWith: nil)
        self.leftButton.setImage(next_img, for: .normal)
        self.leftButton.setImage(next_img, for: .disabled)
        self.addSubview(self.leftButton)
        self.leftButton.addTarget(self.galleryCollection, action: #selector(self.galleryCollection.press(button:)), for: .touchUpInside)
        
        self.leftButton.translatesAutoresizingMaskIntoConstraints = false
        self.leftButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.leftButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.leftButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.leftButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    //MARK: Functions
    public func setButtonImages(left: UIImage, right: UIImage, for state: UIControlState) {
        self.rightButton.setImage(right, for: state)
        self.leftButton.setImage(left, for: state)
    }
}

